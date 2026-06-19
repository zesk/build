#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\nurl - URL. Required. URL to fetch the Content-Length.\n'
base="web.sh"
depends=$'curl\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the size of a remote URL\n\n'
descriptionLineCount="2"
file="bin/build/tools/web.sh"
fn="urlContentLength"
fnMarker="urlcontentlength"
foundNames=([0]="depends" [1]="argument")
line="60"
rawComment=$'Get the size of a remote URL\nDepends: curl\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: url - URL. Required. URL to fetch the Content-Length.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/web.sh"
sourceHash="42cdd7be022533bf6efc3e6efe1957cfc1dc3ef2"
sourceLine="60"
summary="Get the size of a remote URL"
summaryComputed="true"
usage="urlContentLength [ --help ] [ --handler handler ] url"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlContentLength'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl                '$'\e''[[(value)]mURL. Required. URL to fetch the Content-Length.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the size of a remote URL'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: urlContentLength [ --help ] [ --handler handler ] url'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    url                URL. Required. URL to fetch the Content-Length.'$'\n'''$'\n''Get the size of a remote URL'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/url.md"
