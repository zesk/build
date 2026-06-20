#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="character.sh"
credit=$'dsmsk80\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Given a list of integers, output the character codes associated with them (e.g. `chr` in other languages)\n\n'
descriptionLineCount="2"
file="bin/build/tools/character.sh"
fn="characterFromInteger"
fnMarker="characterfrominteger"
foundNames=([0]="credit" [1]="source" [2]="argument")
line="90"
original="characterFromInteger"
rawComment=$'Given a list of integers, output the character codes associated with them (e.g. `chr` in other languages)\nCredit: dsmsk80\nSource: https://mywiki.wooledge.org/BashFAQ/071\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
source=$'https://mywiki.wooledge.org/BashFAQ/071\n'
sourceFile="bin/build/tools/character.sh"
sourceHash="859d1cafed674e6fde294a1f7fca6b467b276cf8"
sourceLine="90"
summary="Given a list of integers, output the character codes associated"
summaryComputed="true"
usage="characterFromInteger [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcharacterFromInteger'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Given a list of integers, output the character codes associated with them (e.g. '$'\e''[[(code)]mchr'$'\e''[[(reset)]m in other languages)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: characterFromInteger [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Given a list of integers, output the character codes associated with them (e.g. chr in other languages)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/character.md"
