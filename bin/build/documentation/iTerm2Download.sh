#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="iterm2.sh"
description="Download an file from remote to terminal host"$'\n'"Argument: file - File. Optional. File to download."$'\n'"Argument: --name name - String. Optional. Target name of the file once downloaded."$'\n'"Argument:"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"stdin: file"$'\n'""
file="bin/build/tools/iterm2.sh"
foundNames=()
rawComment="Download an file from remote to terminal host"$'\n'"Argument: file - File. Optional. File to download."$'\n'"Argument: --name name - String. Optional. Target name of the file once downloaded."$'\n'"Argument:"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"stdin: file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="b59a38e93b87dfec07eac18e712111781b8a471f"
summary="Download an file from remote to terminal host"
usage="iTerm2Download"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Download'$'\e''[0m'$'\n'''$'\n''Download an file from remote to terminal host'$'\n''Argument: file - File. Optional. File to download.'$'\n''Argument: --name name - String. Optional. Target name of the file once downloaded.'$'\n''Argument:'$'\n''Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n''stdin: file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Download'$'\n'''$'\n''Download an file from remote to terminal host'$'\n''Argument: file - File. Optional. File to download.'$'\n''Argument: --name name - String. Optional. Target name of the file once downloaded.'$'\n''Argument:'$'\n''Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n''stdin: file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.452
