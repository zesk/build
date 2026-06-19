#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="theme.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Applies the current theme to text rendered using `decorateThemelessMode`\n\n'
descriptionLineCount="2"
file="bin/build/tools/decorate/theme.sh"
fn="decorateThemed"
fnMarker="decoratethemed"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="70"
rawComment=$'Applies the current theme to text rendered using `decorateThemelessMode`\nArgument: --help - Flag. Optional. Display this help.\nstdin: Text to apply current theme to\nstdout: Console-ready text\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/theme.sh"
sourceHash="96feb31ea27d0e4e970f41f92f9cab4a46cf27d0"
sourceLine="70"
stdin=$'Text to apply current theme to\n'
stdout=$'Console-ready text\n'
summary="Applies the current theme to text rendered using \`decorateThemelessMode\`"
summaryComputed="true"
usage="decorateThemed [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorateThemed'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Applies the current theme to text rendered using '$'\e''[[(code)]mdecorateThemelessMode'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Text to apply current theme to'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Console-ready text'
# shellcheck disable=SC2016
helpPlain='Usage: decorateThemed [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Applies the current theme to text rendered using decorateThemelessMode'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Text to apply current theme to'$'\n'''$'\n''Writes to stdout:'$'\n''Console-ready text'
documentationPath="documentation/source/tools/decoration.md"
