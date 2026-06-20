#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--no-app - Flag. Optional. Do not map the application path in `decoratePath`\nfileName - Required. File path to output.\ntext - String. Optional. Text to output linked to file.\n'
base="console.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'decorate extension for `file`\n\n'
descriptionLineCount="2"
environment=$'BUILD_HOME TMPDIR HOME\n'
file="bin/build/tools/console.sh"
fn="__decorateExtensionFile"
fnMarker="__decorateextensionfile"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="environment")
line="268"
original="__decorateExtensionFile"
rawComment=$'Summary: decorate file links\ndecorate extension for `file`\nArgument: --no-app - Flag. Optional. Do not map the application path in `decoratePath`\nArgument: fileName - Required. File path to output.\nArgument: text - String. Optional. Text to output linked to file.\nSee: decoratePath\nEnvironment: BUILD_HOME TMPDIR HOME\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'decoratePath\n'
sourceFile="bin/build/tools/console.sh"
sourceHash="0e80c2ac41033836c3905696efb51ddeab9575b8"
sourceLine="268"
summary="decorate file links"
summaryComputed=""
usage="__decorateExtensionFile [ --no-app ] fileName [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__decorateExtensionFile'$'\e''[0m '$'\e''[[(blue)]m[ --no-app ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfileName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--no-app  '$'\e''[[(value)]mFlag. Optional. Do not map the application path in '$'\e''[[(code)]mdecoratePath'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfileName  '$'\e''[[(value)]mRequired. File path to output.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext      '$'\e''[[(value)]mString. Optional. Text to output linked to file.'$'\e''[[(reset)]m'$'\n'''$'\n''decorate extension for '$'\e''[[(code)]mfile'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOME TMPDIR HOME'
# shellcheck disable=SC2016
helpPlain='Usage: __decorateExtensionFile [ --no-app ] fileName [ text ]'$'\n'''$'\n''    --no-app  Flag. Optional. Do not map the application path in decoratePath'$'\n''    fileName  Required. File path to output.'$'\n''    text      String. Optional. Text to output linked to file.'$'\n'''$'\n''decorate extension for file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOME TMPDIR HOME'
documentationPath="documentation/source/tools/decorate.md"
