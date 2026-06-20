#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'text - String. Required. Text to search for mapping tokens.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Check if text contains plain text only (no ANSI escape codes, etc.)\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="isPlain"
fnMarker="isplain"
foundNames=([0]="argument" [1]="return_code")
line="90"
original="isPlain"
rawComment=$'Check if text contains plain text only (no ANSI escape codes, etc.)\nArgument: text - String. Required. Text to search for mapping tokens.\nWithout arguments, displays help.\nReturn code: - `0` - Text is plain\nReturn code: - `1` - Text contains non-plain characters\n\n'
return_code=$'- `0` - Text is plain\n- `1` - Text contains non-plain characters\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="6d769d6727070a6dc8632961d7250fe1f73eea0f"
sourceLine="90"
summary="Check if text contains plain text only (no ANSI escape"
summaryComputed="true"
usage="isPlain text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misPlain'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtext  '$'\e''[[(value)]mString. Required. Text to search for mapping tokens.'$'\e''[[(reset)]m'$'\n'''$'\n''Check if text contains plain text only (no ANSI escape codes, etc.)'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Text is plain'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Text contains non-plain characters'
# shellcheck disable=SC2016
helpPlain='Usage: isPlain text'$'\n'''$'\n''    text  String. Required. Text to search for mapping tokens.'$'\n'''$'\n''Check if text contains plain text only (no ANSI escape codes, etc.)'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Text is plain'$'\n''- 1 - Text contains non-plain characters'
documentationPath="documentation/source/tools/text.md"
