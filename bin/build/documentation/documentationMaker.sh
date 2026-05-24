#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--verbose - Flag. Optional. Be wordy.\n--default defaultValue - EmptyString. Optional. Pass `--default` flag to `mapFunction`\nsourcePath - Exists. Required. File or directory to convert.\ntargetPath - FileDirectory. Optional. Outputs to `stdout` if not specified, otherwise outputs mirror.\nmapFunction ... - Function. Optional. Mapping function to use, and any arguments.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate documentation using source markdown and a mapping function.\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationMaker"
fnMarker="documentationmaker"
foundNames=([0]="argument" [1]="return_code")
line="443"
rawComment=$'Generate documentation using source markdown and a mapping function.\nArgument: --verbose - Flag. Optional. Be wordy.\nArgument: --default defaultValue - EmptyString. Optional. Pass `--default` flag to `mapFunction`\nArgument: sourcePath - Exists. Required. File or directory to convert.\nArgument: targetPath - FileDirectory. Optional. Outputs to `stdout` if not specified, otherwise outputs mirror.\nArgument: mapFunction ... - Function. Optional. Mapping function to use, and any arguments.\nReturn Code: 0 - Success\nReturn Code: 1 - Template file not found\n\n'
return_code=$'0 - Success\n1 - Template file not found\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="8eb3966e2b01069497c46079393754dd3f3ece3a"
sourceLine="443"
summary="Generate documentation using source markdown and a mapping function."
summaryComputed="true"
usage="documentationMaker [ --verbose ] [ --default defaultValue ] sourcePath [ targetPath ] [ mapFunction ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationMaker'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --default defaultValue ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msourcePath'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ targetPath ]'$'\e''[0m '$'\e''[[(blue)]m[ mapFunction ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--verbose               '$'\e''[[(value)]mFlag. Optional. Be wordy.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--default defaultValue  '$'\e''[[(value)]mEmptyString. Optional. Pass '$'\e''[[(code)]m--default'$'\e''[[(reset)]m flag to '$'\e''[[(code)]mmapFunction'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msourcePath              '$'\e''[[(value)]mExists. Required. File or directory to convert.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtargetPath              '$'\e''[[(value)]mFileDirectory. Optional. Outputs to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m if not specified, otherwise outputs mirror.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmapFunction ...         '$'\e''[[(value)]mFunction. Optional. Mapping function to use, and any arguments.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate documentation using source markdown and a mapping function.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Template file not found'
# shellcheck disable=SC2016
helpPlain='Usage: documentationMaker [ --verbose ] [ --default defaultValue ] sourcePath [ targetPath ] [ mapFunction ... ]'$'\n'''$'\n''    --verbose               Flag. Optional. Be wordy.'$'\n''    --default defaultValue  EmptyString. Optional. Pass --default flag to mapFunction'$'\n''    sourcePath              Exists. Required. File or directory to convert.'$'\n''    targetPath              FileDirectory. Optional. Outputs to stdout if not specified, otherwise outputs mirror.'$'\n''    mapFunction ...         Function. Optional. Mapping function to use, and any arguments.'$'\n'''$'\n''Generate documentation using source markdown and a mapping function.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Template file not found'
documentationPath=""
