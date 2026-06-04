#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML \`property\` tags."$'\n'""
base="junit.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output list of \`property\` tags"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/junit.sh"
fn="junitPropertyList"
fnMarker="junitpropertylist"
foundNames=([0]="argument")
line="122"
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Output list of \`property\` tags"$'\n'"Argument: nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML \`property\` tags."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="b434c2cb872c8920849edb82446bed7ed134f6d2"
sourceLine="122"
summary="Output list of \`property\` tags"
summaryComputed="true"
usage="junitPropertyList [ --help ] [ nameValue ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitPropertyList'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ nameValue ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mnameValue ...  '$'\e''[[(value)]mOptional. String. A list of name value pairs (unquoted) to output as XML '$'\e''[[(code)]mproperty'$'\e''[[(reset)]m tags.'$'\e''[[(reset)]m'$'\n'''$'\n''Output list of '$'\e''[[(code)]mproperty'$'\e''[[(reset)]m tags'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: junitPropertyList [ --help ] [ nameValue ... ]'$'\n'''$'\n''    --help         Flag. Optional. Display this help.'$'\n''    nameValue ...  Optional. String. A list of name value pairs (unquoted) to output as XML property tags.'$'\n'''$'\n''Output list of property tags'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/junit.md"
