# mirerfangheibi.github.io

Source for my personal website, [mirerfangheibi.github.io](https://mirerfangheibi.github.io).

Built with [Jekyll](https://jekyllrb.com/) on top of the [al-folio](https://github.com/alshedivat/al-folio) theme (v1.x). The theme's layouts, includes and styles come from the `al_folio_*` gems; this repository holds the site content and a few local overrides.

## Where things live

| What                            | Where                                                                  |
| ------------------------------- | ---------------------------------------------------------------------- |
| Site settings                   | `_config.yml`                                                          |
| Social links                    | `_data/socials.yml`                                                    |
| About page (bio, news, papers)  | `_pages/about.md`, `_news/`                                            |
| Publications                    | `_bibliography/papers.bib`, `_data/venues.yml`, `_data/coauthors.yml`  |
| Teaching                        | `_pages/teaching.md`                                                   |
| Blog                            | `_posts/`; external posts come from `external_sources` in `_config.yml` |
| ML study resources page         | `_pages/resources.md`, `_data/ml_resources_{books,courses}.yml`        |

### Local overrides of the theme

- `_layouts/resources.liquid`, `_includes/books_grid.liquid`, `_includes/courses_grid.liquid` are the study resources page.
- `_sass/_custom.scss` holds site-specific CSS. It is loaded by a local copy of the theme's `assets/css/main.scss` (the only change there is the final `@use "custom";` line).

The copy of `assets/css/main.scss` shadows a gem-owned file and is recorded in `.al-folio-overrides.yml`, so theme updates that change it get flagged (see below).

## Run locally

Requires Ruby 3.2+ (e.g. via rbenv) and ImageMagick.

```bash
bundle install
bundle exec jekyll serve --livereload
```

Then open <http://127.0.0.1:4000>. Changes to `_config.yml` need a server restart.

## Deploy

Pushing to `master` runs `.github/workflows/deploy.yml`, which builds the site, removes unused CSS with purgecss, and pushes the result to the `gh-pages` branch that GitHub Pages serves.

## Updating from upstream al-folio

```bash
git fetch upstream
git merge upstream/main
bundle update
bundle exec al-folio upgrade audit          # must report 0 blocking findings
bundle exec al-folio upgrade overrides audit # flags theme changes to overridden files
```

If the overrides audit flags `assets/css/main.scss`, compare it with `bundle exec al-folio upgrade overrides diff assets/css/main.scss`, re-copy the theme version with the `@use "custom";` line added back, then run `bundle exec al-folio upgrade overrides accept assets/css/main.scss`.

Upstream sample content, maintainer workflows and the template README were removed from this repository. If a merge brings them back, keep them deleted.

## License

The al-folio theme is released under the [MIT License](LICENSE). The site content (text, images, publications) is mine.
