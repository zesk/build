#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'None\n'
base="console.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set the title of the window for the console to "user@hostname: pwd"\n\n'
descriptionLineCount="2"
file="bin/build/tools/console.sh"
fn="consoleDefaultTitle"
fnMarker="consoledefaulttitle"
foundNames=([0]="argument")
line="172"
original="consoleDefaultTitle"
rawComment=$'Set the title of the window for the console to "user@hostname: pwd"\nArgument: None\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/console.sh"
sourceHash="0e80c2ac41033836c3905696efb51ddeab9575b8"
sourceLine="172"
summary="Set the title of the window for the console to"
summaryComputed="true"
usage="consoleDefaultTitle [ None ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleDefaultTitle'$'\e''[0m '$'\e''[[(blue)]m[ None ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mNone  '$'\e''[[(value)]mNone'$'\e''[[(reset)]m'$'\n'''$'\n''Set the title of the window for the console to "user@hostname: pwd"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: consoleDefaultTitle [ None ]'$'\n'''$'\n''    None  None'$'\n'''$'\n''Set the title of the window for the console to "user@hostname: pwd"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/console.md"
