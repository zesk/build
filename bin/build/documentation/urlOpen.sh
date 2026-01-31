#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--ignore - Flag. Optional. Ignore any invalid URLs found."$'\n'"--wait - Flag. Optional. Display this help."$'\n'"--url url - URL. Optional. URL to download."$'\n'""
base="url.sh"
description="Open a URL using the operating system"$'\n'"Usage {fn} [ --help ]"$'\n'""
file="bin/build/tools/url.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Open a URL using the operating system"$'\n'"Usage {fn} [ --help ]"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --ignore - Flag. Optional. Ignore any invalid URLs found."$'\n'"Argument: --wait - Flag. Optional. Display this help."$'\n'"Argument: --url url - URL. Optional. URL to download."$'\n'"stdin: line:URL"$'\n'"stdout: none"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="7a4bdc5b163f1c16b416ea3bac111f15d9a5f6b1"
stdin="line:URL"$'\n'""
stdout="none"$'\n'""
summary="Open a URL using the operating system"
summaryComputed="true"
usage="urlOpen [ --help ] [ --ignore ] [ --wait ] [ --url url ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlOpen'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --ignore ]'$'\e''[0m '$'\e''[[(blue)]m[ --wait ]'$'\e''[0m '$'\e''[[(blue)]m[ --url url ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--ignore   '$'\e''[[(value)]mFlag. Optional. Ignore any invalid URLs found.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--wait     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--url url  '$'\e''[[(value)]mURL. Optional. URL to download.'$'\e''[[(reset)]m'$'\n'''$'\n''Open a URL using the operating system'$'\n''Usage urlOpen [ --help ]'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''line:URL'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''none'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]murlOpen [ --help ] [ --ignore ] [ --wait ] [ --url url ]'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    --ignore   Flag. Optional. Ignore any invalid URLs found.'$'\n''    --wait     Flag. Optional. Display this help.'$'\n''    --url url  URL. Optional. URL to download.'$'\n'''$'\n''Open a URL using the operating system'$'\n''Usage urlOpen [ --help ]'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''line:URL'$'\n'''$'\n''Writes to stdout:'$'\n''none'$'\n'''
# elapsed 3.772
