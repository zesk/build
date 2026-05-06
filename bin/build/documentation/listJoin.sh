#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter."$'\n'"text0 ... - String. Optional. One or more strings to join"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output a list of items joined by a character"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/list.sh"
fn="listJoin"
fnMarker="listjoin"
foundNames=([0]="output" [1]="argument")
line="23"
output="text"$'\n'""
rawComment="Output a list of items joined by a character"$'\n'"Output: text"$'\n'"Argument: separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter."$'\n'"Argument: text0 ... - String. Optional. One or more strings to join"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="3f580df9b039d92b40c8f1a751e6a2027746278d"
sourceLine="23"
summary="Output a list of items joined by a character"
summaryComputed="true"
usage="listJoin separator [ text0 ... ] [ --help ]"
