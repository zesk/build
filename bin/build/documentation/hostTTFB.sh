#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nurl - URL. Required. URL to check.\n'
base="web.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Fetch Time to First Byte and other stats\n\n'
descriptionLineCount="2"
file="bin/build/tools/web.sh"
fn="hostTTFB"
fnMarker="hostttfb"
foundNames=([0]="argument")
line="97"
rawComment=$'Fetch Time to First Byte and other stats\nArgument: --help - Flag. Optional. Display this help.\nArgument: url - URL. Required. URL to check.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/web.sh"
sourceHash="e13b8cb53898482442171ddd6250196c36d71146"
sourceLine="97"
summary="Fetch Time to First Byte and other stats"
summaryComputed="true"
usage="hostTTFB [ --help ] url"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhostTTFB'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl     '$'\e''[[(value)]mURL. Required. URL to check.'$'\e''[[(reset)]m'$'\n'''$'\n''Fetch Time to First Byte and other stats'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: hostTTFB [ --help ] url'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    url     URL. Required. URL to check.'$'\n'''$'\n''Fetch Time to First Byte and other stats'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/web.md"
