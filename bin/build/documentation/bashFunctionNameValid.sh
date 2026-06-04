#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Does not check if a function is defined, just whether the name would be acceptable as a function name in Bash.\n\n'
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashFunctionNameValid"
fnMarker="bashfunctionnamevalid"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="650"
rawComment=$'Summary: Is a string a valid function name?\nArgument: --help - Flag. Optional. Display this help.\nDoes not check if a function is defined, just whether the name would be acceptable as a function name in Bash.\nReturn Code: 0 - All values passed are valid function names for bash functions\nReturn Code: 1 - One or more values passed are NOT valid function names for bash functions\n\n'
return_code=$'0 - All values passed are valid function names for bash functions\n1 - One or more values passed are NOT valid function names for bash functions\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="0bec62237f4e812ee319f8b7f774905396bb742b"
sourceLine="650"
summary="Is a string a valid function name?"
summaryComputed=""
usage="bashFunctionNameValid [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFunctionNameValid'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Does not check if a function is defined, just whether the name would be acceptable as a function name in Bash.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All values passed are valid function names for bash functions'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more values passed are NOT valid function names for bash functions'
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionNameValid [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Does not check if a function is defined, just whether the name would be acceptable as a function name in Bash.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All values passed are valid function names for bash functions'$'\n''- 1 - One or more values passed are NOT valid function names for bash functions'
documentationPath="documentation/source/tools/bash.md"
