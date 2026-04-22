#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Parses text and determines if it's true-ish"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
fn="booleanParse"
foundNames=([0]="return_code" [1]="requires")
line="155"
lowerFn="booleanparse"
rawComment="Parses text and determines if it's true-ish"$'\n'"Return Code: 0 - true"$'\n'"Return Code: 1 - false"$'\n'"Return Code: 2 - Neither"$'\n'"Requires: stringLowercase helpArgument"$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""$'\n'""
requires="stringLowercase helpArgument"$'\n'""
return_code="0 - true"$'\n'"1 - false"$'\n'"2 - Neither"$'\n'"- \`0\` - Text is plain"$'\n'"- \`1\` - Text contains non-plain characters"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="50153fd5ef57624e1e417cf7f8cf53ca2489a784"
sourceLine="155"
summary="Parses text and determines if it's true-ish"
summaryComputed="true"
usage="booleanParse"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbooleanParse'$'\e''[0m'$'\n'''$'\n''Parses text and determines if it'\''s true-ish'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - true'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - false'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Neither'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Text is plain'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Text contains non-plain characters'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: booleanParse'$'\n'''$'\n''Parses text and determines if it'\''s true-ish'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - true'$'\n''- 1 - false'$'\n''- 2 - Neither'$'\n''- 0 - Text is plain'$'\n''- 1 - Text contains non-plain characters'$'\n'''
documentationPath="documentation/source/tools/text.md"
