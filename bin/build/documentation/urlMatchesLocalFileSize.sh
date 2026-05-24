#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nurl - URL. Required. URL to check.\nfile - File. Required. File to compare.\n'
base="web.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Compare a remote file size with a local file size\n\n'
descriptionLineCount="2"
file="bin/build/tools/web.sh"
fn="urlMatchesLocalFileSize"
fnMarker="urlmatcheslocalfilesize"
foundNames=([0]="argument")
line="13"
rawComment=$'Compare a remote file size with a local file size\nArgument: --help - Flag. Optional. Display this help.\nArgument: url - URL. Required. URL to check.\nArgument: file - File. Required. File to compare.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/web.sh"
sourceHash="e13b8cb53898482442171ddd6250196c36d71146"
sourceLine="13"
summary="Compare a remote file size with a local file size"
summaryComputed="true"
usage="urlMatchesLocalFileSize [ --help ] url file"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlMatchesLocalFileSize'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl     '$'\e''[[(value)]mURL. Required. URL to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile    '$'\e''[[(value)]mFile. Required. File to compare.'$'\e''[[(reset)]m'$'\n'''$'\n''Compare a remote file size with a local file size'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: urlMatchesLocalFileSize [ --help ] url file'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    url     URL. Required. URL to check.'$'\n''    file    File. Required. File to compare.'$'\n'''$'\n''Compare a remote file size with a local file size'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/url.md"
