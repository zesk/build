#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="web.sh"
description="Scrape a website."$'\n'"Untested, and in progress. Do not use seriously."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url - URL. Required. Url to scrape recursively."$'\n'"Untested: true"$'\n'"Uses \`wget\` to fetch a site, convert it to HTML nad rewrite it for local consumption."$'\n'"Site is stored in a directory called \`host\` for the URL requested."$'\n'"This is not final yet and may not work properly."$'\n'""
file="bin/build/tools/web.sh"
foundNames=()
rawComment="Scrape a website."$'\n'"Untested, and in progress. Do not use seriously."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url - URL. Required. Url to scrape recursively."$'\n'"Untested: true"$'\n'"Uses \`wget\` to fetch a site, convert it to HTML nad rewrite it for local consumption."$'\n'"Site is stored in a directory called \`host\` for the URL requested."$'\n'"This is not final yet and may not work properly."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceHash="1fcdcd2f89593d5b69e5f6e898f0f7281cff2e61"
summary="Scrape a website."
usage="websiteScrape"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mwebsiteScrape'$'\e''[0m'$'\n'''$'\n''Scrape a website.'$'\n''Untested, and in progress. Do not use seriously.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: url - URL. Required. Url to scrape recursively.'$'\n''Untested: true'$'\n''Uses '$'\e''[[(code)]mwget'$'\e''[[(reset)]m to fetch a site, convert it to HTML nad rewrite it for local consumption.'$'\n''Site is stored in a directory called '$'\e''[[(code)]mhost'$'\e''[[(reset)]m for the URL requested.'$'\n''This is not final yet and may not work properly.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: websiteScrape'$'\n'''$'\n''Scrape a website.'$'\n''Untested, and in progress. Do not use seriously.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: url - URL. Required. Url to scrape recursively.'$'\n''Untested: true'$'\n''Uses wget to fetch a site, convert it to HTML nad rewrite it for local consumption.'$'\n''Site is stored in a directory called host for the URL requested.'$'\n''This is not final yet and may not work properly.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.474
