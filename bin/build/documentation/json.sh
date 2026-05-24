#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="json.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Format something neatly as JSON\n\n'
descriptionLineCount="2"
example=$'    json < inputFile > outputFile\n'
file="bin/build/tools/json.sh"
fn="json"
fnMarker="json"
foundNames=([0]="argument" [1]="summary" [2]="example" [3]="stdin" [4]="stdout")
line="258"
rawComment=$'Argument: --help - Flag. Optional. Display this help.\nSummary: JSON pretty\nFormat something neatly as JSON\nExample:     json < inputFile > outputFile\nstdin: JSONFile\nstdout: JSONFile pretty formatted\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/json.sh"
sourceHash="e4fa7a237368db1e6a6969ecf3a1c6f05241d727"
sourceLine="258"
stdin=$'JSONFile\n'
stdout=$'JSONFile pretty formatted\n'
summary="JSON pretty"
summaryComputed=""
usage="json [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjson'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Format something neatly as JSON'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''JSONFile'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''JSONFile pretty formatted'$'\n'''$'\n''Example:'$'\n''    json < inputFile > outputFile'
# shellcheck disable=SC2016
helpPlain='Usage: json [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Format something neatly as JSON'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''JSONFile'$'\n'''$'\n''Writes to stdout:'$'\n''JSONFile pretty formatted'$'\n'''$'\n''Example:'$'\n''    json < inputFile > outputFile'
documentationPath="documentation/source/tools/json.md"
