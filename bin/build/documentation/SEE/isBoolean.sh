#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"value - String. Optional. Value to check if it is a boolean."$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Boolean test"$'\n'"If you want \"true-ish\" use \`isTrue\`."$'\n'"Returns 0 if \`value\` is boolean \`false\` oHar \`true\`."$'\n'"Is this a boolean? (\`true\` or \`false\`)"$'\n'""$'\n'""
descriptionLineCount="5"
file="bin/build/tools/_sugar.sh"
fn="isBoolean"
fnMarker="isboolean"
foundNames=([0]="return_code" [1]="see" [2]="argument" [3]="requires")
line="79"
rawComment="Boolean test"$'\n'"If you want \"true-ish\" use \`isTrue\`."$'\n'"Returns 0 if \`value\` is boolean \`false\` oHar \`true\`."$'\n'"Is this a boolean? (\`true\` or \`false\`)"$'\n'"Return Code: 0 - if value is a boolean"$'\n'"Return Code: 1 - if value is not a boolean"$'\n'"See: isTrue booleanParse"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - String. Optional. Value to check if it is a boolean."$'\n'"Requires: bashDocumentation"$'\n'""$'\n'""
requires="bashDocumentation"$'\n'""
return_code="0 - if value is a boolean"$'\n'"1 - if value is not a boolean"$'\n'""
see="isTrue booleanParse"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="f483140af62e442b07342b869da4ea17b676a4e1"
sourceLine="79"
summary="Boolean test"
summaryComputed="true"
usage="isBoolean [ --help ] [ value ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBoolean'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue   '$'\e''[[(value)]mString. Optional. Value to check if it is a boolean.'$'\e''[[(reset)]m'$'\n'''$'\n''Boolean test'$'\n''If you want "true-ish" use '$'\e''[[(code)]misTrue'$'\e''[[(reset)]m.'$'\n''Returns 0 if '$'\e''[[(code)]mvalue'$'\e''[[(reset)]m is boolean '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m oHar '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m.'$'\n''Is this a boolean? ('$'\e''[[(code)]mtrue'$'\e''[[(reset)]m or '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if value is a boolean'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if value is not a boolean'
# shellcheck disable=SC2016
helpPlain='Usage: isBoolean [ --help ] [ value ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    value   String. Optional. Value to check if it is a boolean.'$'\n'''$'\n''Boolean test'$'\n''If you want "true-ish" use isTrue.'$'\n''Returns 0 if value is boolean false oHar true.'$'\n''Is this a boolean? (true or false)'$'\n'''$'\n''Return codes:'$'\n''- 0 - if value is a boolean'$'\n''- 1 - if value is not a boolean'
documentationPath="documentation/source/tools/sugar-core.md"
