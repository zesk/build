#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"url - URL. Required. URL to check."$'\n'"file - File. Required. File to compare."$'\n'""
base="web.sh"
description="Compare a remote file size with a local file size"$'\n'""
file="bin/build/tools/web.sh"
foundNames=([0]="argument")
rawComment="Compare a remote file size with a local file size"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url - URL. Required. URL to check."$'\n'"Argument: file - File. Required. File to compare."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceHash="1fcdcd2f89593d5b69e5f6e898f0f7281cff2e61"
summary="Compare a remote file size with a local file size"
summaryComputed="true"
usage="urlMatchesLocalFileSize [ --help ] url file"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlMatchesLocalFileSize'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl     '$'\e''[[(value)]mURL. Required. URL to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile    '$'\e''[[(value)]mFile. Required. File to compare.'$'\e''[[(reset)]m'$'\n'''$'\n''Compare a remote file size with a local file size'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlMatchesLocalFileSize [ --help ] url file'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    [[(red)]murl     URL. Required. URL to check.'$'\n''    [[(red)]mfile    File. Required. File to compare.'$'\n'''$'\n''Compare a remote file size with a local file size'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
