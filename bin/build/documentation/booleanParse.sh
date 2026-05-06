#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
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
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="155"
summary="Parses text and determines if it's true-ish"
summaryComputed="true"
usage="booleanParse"
