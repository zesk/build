#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="none"
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Parses text and determines if it's true-ish"$'\n'""$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/text.sh"
fn="booleanParse"
fnMarker="booleanparse"
foundNames=([0]="return_code" [1]="requires")
line="155"
rawComment="Parses text and determines if it's true-ish"$'\n'"Return Code: 0 - true"$'\n'"Return Code: 1 - false"$'\n'"Return Code: 2 - Neither"$'\n'"Requires: stringLowercase helpArgument"$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""$'\n'""
requires="stringLowercase helpArgument"$'\n'""
return_code="0 - true"$'\n'"1 - false"$'\n'"2 - Neither"$'\n'"- \`0\` - Text is plain"$'\n'"- \`1\` - Text contains non-plain characters"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="155"
summary="Parses text and determines if it's true-ish"
summaryComputed="true"
usage="booleanParse"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbooleanParse'$'\e''[0m'$'\n'''$'\n''Parses text and determines if it'\''s true-ish'$'\n'''$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - true'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - false'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Neither'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Text is plain'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Text contains non-plain characters'
# shellcheck disable=SC2016
helpPlain='Usage: booleanParse'$'\n'''$'\n''Parses text and determines if it'\''s true-ish'$'\n'''$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - true'$'\n''- 1 - false'$'\n''- 2 - Neither'$'\n''- 0 - Text is plain'$'\n''- 1 - Text contains non-plain characters'
documentationPath="documentation/source/tools/text.md"
