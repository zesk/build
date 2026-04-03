## `websiteScrape`

> Scrape a website.

### Usage

    websiteScrape [ --help ] url

Scrape a website.
Untested, and in progress. Do not use seriously.
Uses `wget` to fetch a site, convert it to HTML nad rewrite it for local consumption.
Site is stored in a directory called `host` for the URL requested.
This is not final yet and may not work properly.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `url` - URL. Required. Url to scrape recursively.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

