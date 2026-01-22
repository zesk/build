#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="file - File. Optional. File to download."$'\n'"--name name - String. Optional. Target name of the file once downloaded."$'\n'"--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
description="Download an file from remote to terminal host"$'\n'"Argument:"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Download"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceModified="1768759385"
stdin="file"$'\n'""
summary="Download an file from remote to terminal host"
usage="iTerm2Download [ file ] [ --name name ] [ --ignore | -i ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255miTerm2Download[0m [94m[ file ][0m [94m[ --name name ][0m [94m[ --ignore | -i ][0m

    [94mfile           [1;97mFile. Optional. File to download.[0m
    [94m--name name    [1;97mString. Optional. Target name of the file once downloaded.[0m
    [94m--ignore | -i  [1;97mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.[0m

Download an file from remote to terminal host
Argument:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
file
'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Download [ file ] [ --name name ] [ --ignore | -i ]

    file           File. Optional. File to download.
    --name name    String. Optional. Target name of the file once downloaded.
    --ignore | -i  Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.

Download an file from remote to terminal host
Argument:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
file
'
