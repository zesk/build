#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="file - File. Optional. File to download."$'\n'"--name name - String. Optional. Target name of the file once downloaded."$'\n'"--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
description="Download an file from remote to terminal host"$'\n'"Argument:"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Download"
foundNames=([0]="argument" [1]="stdin")
rawComment="Download an file from remote to terminal host"$'\n'"Argument: file - File. Optional. File to download."$'\n'"Argument: --name name - String. Optional. Target name of the file once downloaded."$'\n'"Argument:"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"stdin: file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="ffdea6c44121242f377e23dddf0bd4cc7a3b1244"
stdin="file"$'\n'""
summary="Download an file from remote to terminal host"
summaryComputed="true"
usage="iTerm2Download [ file ] [ --name name ] [ --ignore | -i ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Download'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m '$'\e''[[(blue)]m[ --name name ]'$'\e''[0m '$'\e''[[(blue)]m[ --ignore | -i ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfile           '$'\e''[[(value)]mFile. Optional. File to download.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--name name    '$'\e''[[(value)]mString. Optional. Target name of the file once downloaded.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--ignore | -i  '$'\e''[[(value)]mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\e''[[(reset)]m'$'\n'''$'\n''Download an file from remote to terminal host'$'\n''Argument:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''file'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Download [ file ] [ --name name ] [ --ignore | -i ]'$'\n'''$'\n''    file           File. Optional. File to download.'$'\n''    --name name    String. Optional. Target name of the file once downloaded.'$'\n''    --ignore | -i  Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n'''$'\n''Download an file from remote to terminal host'$'\n''Argument:'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''file'$'\n'''
