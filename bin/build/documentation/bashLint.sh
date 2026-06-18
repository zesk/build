#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--fix - Flag. Optional. Fix files when possible.\n--verbose - Flag. Optional. Be verbose.\nscript - File. Optional. Shell script to validate\n'
base="lint.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run `shellcheck` and `bash -n` on a set of bash files.\n\nThis can be run on any directory tree to test scripts in any application.\n\nShell comments must not be immediately after a function end, e.g. this is invalid:\n\n    myFunc() {\n    }\n    # Hey\n\n'
descriptionLineCount="10"
example=$'    bashLint goo.sh\n'
file="bin/build/tools/lint.sh"
fn="bashLint"
fnMarker="bashlint"
foundNames=([0]="summary" [1]="see" [2]="example" [3]="argument" [4]="side_effect" [5]="return_code" [6]="output")
line="33"
output=$'This outputs `statusMessage`s to `stdout` and errors to `stderr`.\n'
rawComment=$'Summary: Check bash files for common errors\nSee: [shellcheck](https://www.shellcheck.net/)\nSee: bashSanitize\nRun `shellcheck` and `bash -n` on a set of bash files.\nThis can be run on any directory tree to test scripts in any application.\nShell comments must not be immediately after a function end, e.g. this is invalid:\n    myFunc() {\n    }\n    # Hey\nExample:     bashLint goo.sh\nArgument: --help - Flag. Optional. Display this help.\nArgument: --fix - Flag. Optional. Fix files when possible.\nArgument: --verbose - Flag. Optional. Be verbose.\nArgument: script - File. Optional. Shell script to validate\nSide-effect: Status written to stdout, errors written to stderr\nReturn Code: 0 - All found files pass `shellcheck` and `bash -n` and shell comment syntax\nReturn Code: 1 - One or more files did not pass\nOutput: This outputs `statusMessage`s to `stdout` and errors to `stderr`.\n\n'
return_code=$'0 - All found files pass `shellcheck` and `bash -n` and shell comment syntax\n1 - One or more files did not pass\n'
see=$'[shellcheck](https://www.shellcheck.net/)\nbashSanitize\n'
side_effect=$'Status written to stdout, errors written to stderr\n'
sourceFile="bin/build/tools/lint.sh"
sourceHash="001a8d080c4474bfc3bf86b18fd321bcc4aa033e"
sourceLine="33"
summary="Check bash files for common errors"
summaryComputed=""
usage="bashLint [ --help ] [ --fix ] [ --verbose ] [ script ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashLint'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --fix ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ script ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--fix      '$'\e''[[(value)]mFlag. Optional. Fix files when possible.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose  '$'\e''[[(value)]mFlag. Optional. Be verbose.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mscript     '$'\e''[[(value)]mFile. Optional. Shell script to validate'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mshellcheck'$'\e''[[(reset)]m and '$'\e''[[(code)]mbash -n'$'\e''[[(reset)]m on a set of bash files.'$'\n'''$'\n''This can be run on any directory tree to test scripts in any application.'$'\n'''$'\n''Shell comments must not be immediately after a function end, e.g. this is invalid:'$'\n'''$'\n''    myFunc() {'$'\n''    }'$'\n''    # Hey'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All found files pass '$'\e''[[(code)]mshellcheck'$'\e''[[(reset)]m and '$'\e''[[(code)]mbash -n'$'\e''[[(reset)]m and shell comment syntax'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more files did not pass'$'\n'''$'\n''Example:'$'\n''    bashLint goo.sh'
# shellcheck disable=SC2016
helpPlain='Usage: bashLint [ --help ] [ --fix ] [ --verbose ] [ script ]'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    --fix      Flag. Optional. Fix files when possible.'$'\n''    --verbose  Flag. Optional. Be verbose.'$'\n''    script     File. Optional. Shell script to validate'$'\n'''$'\n''Run shellcheck and bash -n on a set of bash files.'$'\n'''$'\n''This can be run on any directory tree to test scripts in any application.'$'\n'''$'\n''Shell comments must not be immediately after a function end, e.g. this is invalid:'$'\n'''$'\n''    myFunc() {'$'\n''    }'$'\n''    # Hey'$'\n'''$'\n''Return codes:'$'\n''- 0 - All found files pass shellcheck and bash -n and shell comment syntax'$'\n''- 1 - One or more files did not pass'$'\n'''$'\n''Example:'$'\n''    bashLint goo.sh'
documentationPath="documentation/source/tools/lint.md"
