#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/web.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"url - URL. Required. URL to fetch the Content-Length."$'\n'""
base="web.sh"
depends="curl"$'\n'""
description="Get the size of a remote URL"$'\n'""
file="bin/build/tools/web.sh"
fn="urlContentLength"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceModified="1769063211"
summary="Get the size of a remote URL"
usage="urlContentLength [ --help ] [ --handler handler ] url"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlContentLength[0m [94m[ --help ][0m [94m[ --handler handler ][0m [38;2;255;255;0m[35;48;2;0;0;0murl[0m[0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [31murl                [1;97mURL. Required. URL to fetch the Content-Length.[0m

Get the size of a remote URL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: urlContentLength [ --help ] [ --handler handler ] url

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    url                URL. Required. URL to fetch the Content-Length.

Get the size of a remote URL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
