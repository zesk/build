#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Strict boolean `false` or `true`\n\n'
descriptionLineCount="2"
file="bin/build/tools/validate.sh"
fn="__validateTypeBoolean"
fnMarker="__validatetypeboolean"
foundNames=()
line="359"
original="__validateTypeBoolean"
rawComment=$'Strict boolean `false` or `true`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="6aa8ba7c4c01e78e1aaa60bba330293420ad5579"
sourceLine="359"
summary="Strict boolean \`false\` or \`true\`"
summaryComputed="true"
usage="__validateTypeBoolean"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeBoolean'$'\e''[0m'$'\n'''$'\n''Strict boolean '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m or '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeBoolean'$'\n'''$'\n''Strict boolean false or true'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
