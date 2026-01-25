#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/web.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"url - URL. Required. URL to fetch the Content-Length."$'\n'""
base="web.sh"
depends="curl"$'\n'""
description="Get the size of a remote URL"$'\n'""
exitCode="0"
file="bin/build/tools/web.sh"
foundNames=([0]="depends" [1]="argument")
rawComment="Get the size of a remote URL"$'\n'"Depends: curl"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: url - URL. Required. URL to fetch the Content-Length."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceModified="1769063211"
summary="Get the size of a remote URL"
usage="urlContentLength [ --help ] [ --handler handler ] url"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]murlContentLength'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ --handler handler ]'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]murl'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help             '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--handler handler  '$'\e''[[value]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]murl                '$'\e''[[value]mURL. Required. URL to fetch the Content-Length.'$'\e''[[reset]m'$'\n'''$'\n''Get the size of a remote URL'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlContentLength [ --help ] [ --handler handler ] url'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    url                URL. Required. URL to fetch the Content-Length.'$'\n'''$'\n''Get the size of a remote URL'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
