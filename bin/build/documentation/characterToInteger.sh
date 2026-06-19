#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'character - String. Optional. One or more characters to convert to their ASCII equivalent.\n--help - Flag. Optional. Display this help.\n'
base="character.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Convert one or more characters from their ascii representation to an integer value.\nRequires a single character to be passed\n\n'
descriptionLineCount="3"
file="bin/build/tools/character.sh"
fn="characterToInteger"
fnMarker="charactertointeger"
foundNames=([0]="summary" [1]="argument")
line="35"
rawComment=$'Summary: Convert a character to the corresponding ASCII code\nArgument: character - String. Optional. One or more characters to convert to their ASCII equivalent.\nArgument: --help - Flag. Optional. Display this help.\nConvert one or more characters from their ascii representation to an integer value.\nRequires a single character to be passed\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/character.sh"
sourceHash="859d1cafed674e6fde294a1f7fca6b467b276cf8"
sourceLine="35"
summary="Convert a character to the corresponding ASCII code"
summaryComputed=""
usage="characterToInteger [ character ] [ --help ]"
