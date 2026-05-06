#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"url - URL. Required. Url to scrape recursively."$'\n'""
base="web.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Scrape a website."$'\n'""$'\n'"Untested, and in progress. Do not use seriously."$'\n'"Uses \`wget\` to fetch a site, convert it to HTML nad rewrite it for local consumption."$'\n'"Site is stored in a directory called \`host\` for the URL requested."$'\n'"This is not final yet and may not work properly."$'\n'""$'\n'""
descriptionLineCount="7"
file="bin/build/tools/web.sh"
fn="websiteScrape"
fnMarker="websitescrape"
foundNames=([0]="argument" [1]="untested")
line="126"
rawComment="Scrape a website."$'\n'"Untested, and in progress. Do not use seriously."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url - URL. Required. Url to scrape recursively."$'\n'"Untested: true"$'\n'"Uses \`wget\` to fetch a site, convert it to HTML nad rewrite it for local consumption."$'\n'"Site is stored in a directory called \`host\` for the URL requested."$'\n'"This is not final yet and may not work properly."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceHash="e13b8cb53898482442171ddd6250196c36d71146"
sourceLine="126"
summary="Scrape a website."
summaryComputed="true"
untested="true"$'\n'""
usage="websiteScrape [ --help ] url"
