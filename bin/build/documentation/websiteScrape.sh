#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/web.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"url - URL. Required. Url to scrape recursively."$'\n'""
base="web.sh"
description="Scrape a website."$'\n'""$'\n'"Untested, and in progress. Do not use seriously."$'\n'"Uses \`wget\` to fetch a site, convert it to HTML nad rewrite it for local consumption."$'\n'"Site is stored in a directory called \`host\` for the URL requested."$'\n'"This is not final yet and may not work properly."$'\n'""
file="bin/build/tools/web.sh"
fn="websiteScrape"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceModified="1768721470"
summary="Scrape a website."
untested="true"$'\n'""
usage="websiteScrape [ --help ] url"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mwebsiteScrape[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0murl[0m[0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [31murl     [1;97mURL. Required. Url to scrape recursively.[0m

Scrape a website.

Untested, and in progress. Do not use seriously.
Uses [38;2;0;255;0;48;2;0;0;0mwget[0m to fetch a site, convert it to HTML nad rewrite it for local consumption.
Site is stored in a directory called [38;2;0;255;0;48;2;0;0;0mhost[0m for the URL requested.
This is not final yet and may not work properly.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: websiteScrape [ --help ] url

    --help  Flag. Optional. Display this help.
    url     URL. Required. Url to scrape recursively.

Scrape a website.

Untested, and in progress. Do not use seriously.
Uses wget to fetch a site, convert it to HTML nad rewrite it for local consumption.
Site is stored in a directory called host for the URL requested.
This is not final yet and may not work properly.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
