#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="text - Text to validate"$'\n'"class0 ... - One or more character classes that the characters in string should match"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Ensure that every character in a text string passes all character class tests"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/character.sh"
fn="stringValidate"
fnMarker="stringvalidate"
foundNames=([0]="argument" [1]="note")
line="35"
note="This is slow."$'\n'""
rawComment="Ensure that every character in a text string passes all character class tests"$'\n'"Argument: text - Text to validate"$'\n'"Argument: class0 ... - One or more character classes that the characters in string should match"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Note: This is slow."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceHash="5a2e05ecbe74faca818a547fd009b4342c8f9e78"
sourceLine="35"
summary="Ensure that every character in a text string passes all"
summaryComputed="true"
usage="stringValidate [ text ] [ class0 ... ] [ --help ]"
