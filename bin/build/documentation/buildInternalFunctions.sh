#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Prints the list of internal functions defined in Zesk Build - for internal documentation use only.\n\n'
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="buildInternalFunctions"
fnMarker="buildinternalfunctions"
foundNames=([0]="argument")
line="140"
original="buildInternalFunctions"
rawComment=$'Argument: --help - Flag. Optional. Display this help.\nPrints the list of internal functions defined in Zesk Build - for internal documentation use only.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="5313b3e93fc327771b540642fff47051da315c49"
sourceLine="140"
summary="Prints the list of internal functions defined in Zesk Build"
summaryComputed="true"
usage="buildInternalFunctions [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildInternalFunctions'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Prints the list of internal functions defined in Zesk Build - for internal documentation use only.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: buildInternalFunctions [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Prints the list of internal functions defined in Zesk Build - for internal documentation use only.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/build.md"
