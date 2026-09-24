# Agent guide for mirerfangheibi.github.io

This is Mirerfan Gheibi's **personal website**, a Jekyll site built on the [al-folio](https://github.com/alshedivat/al-folio) v1.x starter. It is not the al-folio template repo. al-folio's contributor rules (for example "never add `_layouts/`, `_includes/` or `_sass/`") do not apply here: a site built on al-folio may keep local overrides, and this one does.

Most layouts, includes and styles come from gems (`al_folio_core` and the other `al_*` gems, installed under `vendor/bundle/`). A file in this repo with the same path as a gem file overrides it.

## Where to make a change

| Change                                   | Edit                                                                                                    |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Bio, profile photo, home page sections   | `_pages/about.md` (front matter controls news, selected papers and socials), `assets/img/prof_pic.png`  |
| News item                                | new file in `_news/`                                                                                    |
| Publication                              | `_bibliography/papers.bib`; venue badge links in `_data/venues.yml`; co-author links in `_data/coauthors.yml` |
| Teaching                                 | `_pages/teaching.md`                                                                                    |
| Blog post                                | new file in `_posts/`; external posts come from `external_sources` in `_config.yml`                    |
| ML study resources (books, courses)      | `_data/ml_resources_books.yml`, `_data/ml_resources_courses.yml`                                        |
| Social links                             | `_data/socials.yml`                                                                                     |
| Site settings, feature flags             | `_config.yml`                                                                                           |
| CSS tweaks                               | `_sass/_custom.scss`                                                                                    |
| Resources page markup/behavior/styles    | `_pages/resources.md`, `_includes/resources_{filter,tabs}.liquid`, `_includes/{books,courses}_grid.liquid`, `_sass/_ml_resources.scss` |

Prefer content/config changes. Add a new local override of a gem file only when there is no config option, and keep it as small as possible.

## Local overrides (keep this list current)

- `assets/css/main.scss`: copy of `al_folio_core`'s file with one added line, `@use "custom";`, which loads `_sass/_custom.scss`. It is registered in `.al-folio-overrides.yml`.
- `/ml_resources/` site-only includes (no gem equivalent), used by `_pages/resources.md`: `resources_filter.liquid` (one search box + tag buttons above the tabs; filters every `[data-res-list]` container by exact tag and every search word, and writes counts to `[data-count]` and empty messages to `[data-empty]`; the tag button list is at its top), `resources_tabs.liquid` (Books | Courses tabs showing the `.res-panel` with the matching id, so `#Books` / `#Courses` links open a tab; without JS both panels show), `books_grid.liquid` (cards, grid/list toggle remembered in localStorage, native `<dialog>` for descriptions, `onerror` fallback for broken covers) and `courses_grid.liquid` (horizontal cards with the playlist thumbnail and tag chips). Styles are in `_sass/_ml_resources.scss` (loaded from `_sass/_custom.scss`) and use the theme's `--global-*` CSS variables, so dark mode works automatically. The list view class `res-list` is only added by JS, so it is safelisted in `purgecss.config.js`.
- `_plugins/youtube_oembed.rb`: site plugin that, at build time, adds `video` (`title`, `channel`, `thumbnail`) to each course whose `lecture_videos` is a YouTube URL, using key-free YouTube oEmbed with the playlist RSS feed as fallback. `courses_grid.liquid` shows it as a thumbnail. Failures only log a warning and leave `video` unset; if YouTube is unreachable it stops after the first timeout. `YOUTUBE_OEMBED_ENDPOINT` / `YOUTUBE_FEED_ENDPOINT` env vars override the endpoints (used to test the offline path).

If you add or change an override of a gem file, run `bundle exec al-folio upgrade overrides accept <path>` so theme updates to that file get flagged.

## Commands

Ruby 3.2+ is required (the macOS system Ruby is too old; this machine uses rbenv with 3.2.9, e.g. `RBENV_VERSION=3.2.9`).

```bash
bundle install
bundle exec jekyll serve --livereload                     # http://127.0.0.1:4000
JEKYLL_ENV=production bundle exec jekyll build             # what CI runs
bundle exec al-folio upgrade audit --no-fail              # must report 0 blocking
bundle exec al-folio upgrade overrides audit              # checks overridden gem files
```

`_config.yml` changes are not hot-reloaded: restart `jekyll serve`. The audit writes `al-folio-upgrade-report.md`; don't commit it.

Deploy: pushing to `master` runs `.github/workflows/deploy.yml` (production build, purgecss, then push to the `gh-pages` branch that GitHub Pages serves). It is the only workflow; don't add al-folio's maintainer workflows back.

## Gotchas

- **purgecss runs only in CI**, so `jekyll serve` shows CSS that production may delete. It drops rules for selectors not present in the built HTML/JS, which includes elements created at runtime by CDN scripts (e.g. `#back-to-top`). Add such selectors to the `safelist` in `purgecss.config.js`. Inline `<style>` blocks in pages are not affected.

- **Hide content with front matter, not HTML comments.** A file wrapped in `<!-- ... -->` has no front matter, so Jekyll publishes it as a raw file. Use `published: false` (see `_news/announcement_2.md`).
- **`_data/coauthors.yml` keys must be lowercase** (e.g. `"ghazizadeh"`); the theme lowercases last names before looking them up.
- **Publications** are grouped by year automatically (`scholar.group_by: year`); there is no list of years to maintain. `abbr={...}` in a bib entry picks the badge, linked through `_data/venues.yml`.
- **X link** is a custom entry in `_data/socials.yml`, because the plugin's `x_username` still links to twitter.com.
- **Bootstrap/jQuery are not loaded** (`al_folio.compat.bootstrap.enabled: false`). Don't use Bootstrap JS (`data-toggle`, `.modal()`), and don't rely on Bootstrap grid classes.
- **Includes** use the `.liquid` names from the gems, e.g. `{% include figure.liquid path="..." %}`, not the old `figure.html`.
- **Book entries** use `title, book_author, publisher, print_year, front_page (cover URL), book_url, tags, description, supp_material`. Course entries use `title, instructor, year, institute, tags, description, personal_notes, course_url, lecture_videos, lecture_notes, supp_material`. Use the filter vocabulary in `tags` (e.g. `Deep Learning`, `Math`, `Statistics`) so the tag buttons find items. A misspelled key (e.g. `author` instead of `book_author`) is silently ignored. URL values must be bare (no stray trailing `"`): the grids are rendered inside `_pages/resources.md`, so kramdown parses their HTML and prints any malformed tag as literal text. The includes `| escape` URLs as a safety net.
- CV and projects pages are intentionally disabled (`al_folio.features.cv.enabled: false`, `_pages/projects.md` has `nav: false` and `_projects/` is empty).
- No analytics script is used on purpose; search traffic is tracked with Google Search Console (`google_site_verification`). If visitor counts are wanted, prefer `analytics.cloudflare` (free, cookieless) over Google Analytics.

## Updating from upstream al-folio

```bash
git fetch upstream && git merge upstream/main
bundle update
bundle exec al-folio upgrade audit
bundle exec al-folio upgrade overrides audit
```

Upstream sample content, template docs and maintainer workflows were deleted on purpose. If a merge re-adds them or conflicts on them, keep them deleted. If `assets/css/main.scss` is flagged, re-copy the gem version, re-add `@use "custom";` at the end, and accept it again.
