#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"url - URL. Required. Url to scrape recursively."$'\n'""
base="web.sh"
description="Scrape a website."$'\n'"Untested, and in progress. Do not use seriously."$'\n'"Uses \`wget\` to fetch a site, convert it to HTML nad rewrite it for local consumption."$'\n'"Site is stored in a directory called \`host\` for the URL requested."$'\n'"This is not final yet and may not work properly."$'\n'""
file="bin/build/tools/web.sh"
fn="websiteScrape"
foundNames=([0]="argument" [1]="untested")
rawComment="Scrape a website."$'\n'"Untested, and in progress. Do not use seriously."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url - URL. Required. Url to scrape recursively."$'\n'"Untested: true"$'\n'"Uses \`wget\` to fetch a site, convert it to HTML nad rewrite it for local consumption."$'\n'"Site is stored in a directory called \`host\` for the URL requested."$'\n'"This is not final yet and may not work properly."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceHash="1fcdcd2f89593d5b69e5f6e898f0f7281cff2e61"
summary="Scrape a website."
summaryComputed="true"
untested="true"$'\n'""
usage="websiteScrape [ --help ] url"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mwebsiteScrape'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl     '$'\e''[[(value)]mURL. Required. Url to scrape recursively.'$'\e''[[(reset)]m'$'\n'''$'\n''Scrape a website.'$'\n''Untested, and in progress. Do not use seriously.'$'\n''Uses '$'\e''[[(code)]mwget'$'\e''[[(reset)]m to fetch a site, convert it to HTML nad rewrite it for local consumption.'$'\n''Site is stored in a directory called '$'\e''[[(code)]mhost'$'\e''[[(reset)]m for the URL requested.'$'\n''This is not final yet and may not work properly.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: websiteScrape [ --help ] url'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    url     URL. Required. Url to scrape recursively.'$'\n'''$'\n''Scrape a website.'$'\n''Untested, and in progress. Do not use seriously.'$'\n''Uses wget to fetch a site, convert it to HTML nad rewrite it for local consumption.'$'\n''Site is stored in a directory called host for the URL requested.'$'\n''This is not final yet and may not work properly.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
