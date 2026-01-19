#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/web.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"url - URL. Required. Url to scrape recursively."$'\n'""
base="web.sh"
description="Scrape a website."$'\n'""$'\n'"Untested, and in progress. Do not use seriously."$'\n'"Uses \`wget\` to fetch a site, convert it to HTML nad rewrite it for local consumption."$'\n'"Site is stored in a directory called \`host\` for the URL requested."$'\n'"This is not final yet and may not work properly."$'\n'""
file="bin/build/tools/web.sh"
fn="websiteScrape"
foundNames=([0]="argument" [1]="untested")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/web.sh"
summary="Scrape a website."
untested="true"$'\n'""
usage="websiteScrape [ --help ] url"
