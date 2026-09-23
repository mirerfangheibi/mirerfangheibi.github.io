# frozen_string_literal: true

require "cgi"
require "json"
require "net/http"
require "uri"

# Adds `video` (title, channel, thumbnail) to each course in
# _data/ml_resources_courses.yml whose `lecture_videos` is a YouTube URL, using
# YouTube's key-free endpoints at build time: oEmbed first, then the playlist
# RSS feed (oEmbed refuses some playlists, e.g. when embedding is restricted).
# Any failure just leaves `video` unset, so the course card renders without a
# thumbnail.
module YoutubeOembed
  ENDPOINT = ENV.fetch("YOUTUBE_OEMBED_ENDPOINT", "https://www.youtube.com/oembed")
  FEED_ENDPOINT = ENV.fetch("YOUTUBE_FEED_ENDPOINT", "https://www.youtube.com/feeds/videos.xml")

  class Generator < Jekyll::Generator
    safe true
    priority :high

    # Survives `jekyll serve` rebuilds, so each playlist is fetched once per process.
    CACHE = {}

    # Connection-level failures: YouTube is unreachable, so don't wait on every other request.
    NETWORK_ERRORS = [Net::OpenTimeout, SocketError, Errno::ECONNREFUSED, Errno::EHOSTUNREACH,
                      Errno::ENETUNREACH].freeze

    def generate(site)
      @unreachable = false
      courses = site.data["ml_resources_courses"] || []
      courses.each do |course|
        url = course["lecture_videos"].to_s
        next unless url.match?(%r{\Ahttps?://(www\.)?(youtube\.com|youtu\.be)/})

        unless CACHE.key?(url)
          next if @unreachable

          video = fetch(url)
          CACHE[url] = video unless @unreachable # retry on the next rebuild instead
        end
        course["video"] = CACHE[url] if CACHE[url]
      end
    end

    private

    def fetch(url)
      from_oembed(url)
    rescue StandardError => oembed_error
      return nil if @unreachable

      begin
        from_feed(url)
      rescue StandardError => feed_error
        Jekyll.logger.warn "YoutubeOembed:",
                           "no thumbnail for #{url} (oEmbed: #{oembed_error.message}; feed: #{feed_error.message})"
        nil
      end
    end

    def from_oembed(url)
      data = JSON.parse(get(ENDPOINT, url: url, format: "json"))
      video(data["title"], data["author_name"], data["thumbnail_url"])
    end

    # Only playlists have a feed; the first entry's thumbnail stands in for the playlist.
    def from_feed(url)
      list = URI.decode_www_form(URI(url).query.to_s).to_h["list"] or raise "not a playlist"
      xml = get(FEED_ENDPOINT, playlist_id: list)
      video(xml[%r{<title>([^<]*)</title>}, 1], xml[%r{<author>\s*<name>([^<]*)</name>}, 1],
            xml[/<media:thumbnail url="([^"]+)"/, 1])
    end

    def video(title, channel, thumbnail)
      raise "no thumbnail in response" if thumbnail.to_s.empty?

      {
        "title" => CGI.unescapeHTML(title.to_s),
        "channel" => CGI.unescapeHTML(channel.to_s),
        # mqdefault is 16:9; hqdefault is 4:3 with black bars.
        "thumbnail" => thumbnail.sub(%r{\Ahttps://i\d\.ytimg\.com/}, "https://i.ytimg.com/").sub("/hqdefault.jpg", "/mqdefault.jpg"),
      }
    end

    def get(endpoint, params)
      uri = URI(endpoint)
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https",
                                                     open_timeout: 5, read_timeout: 5) do |http|
        http.get(uri.request_uri)
      end
      raise "HTTP #{response.code}" unless response.is_a?(Net::HTTPSuccess)

      response.body
    rescue *NETWORK_ERRORS => e
      @unreachable = true
      Jekyll.logger.warn "YoutubeOembed:", "YouTube unreachable (#{e.class}); skipping playlist thumbnails"
      raise
    end
  end
end
