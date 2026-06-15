#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--verbose - Flag. Optional. Use more words or phrases than absolutely essential.\n--dry-run - Flag. Optional. Do not do any thing, just say what would be done.\n--git - Flag. Remove from git.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove a function from the documentation cache\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationFunctionRemove"
fnMarker="documentationfunctionremove"
foundNames=([0]="argument" [1]="stdin")
line="583"
rawComment=$'Remove a function from the documentation cache\nArgument: --verbose - Flag. Optional. Use more words or phrases than absolutely essential.\nArgument: --dry-run - Flag. Optional. Do not do any thing, just say what would be done.\nArgument: --git - Flag. Remove from git.\nstdin: functionName - File with function names one per line.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="38500aa3e5be0ae446052278e0b3ea877261e5a8"
sourceLine="583"
stdin=$'functionName - File with function names one per line.\n'
summary="Remove a function from the documentation cache"
summaryComputed="true"
usage="documentationFunctionRemove [ --verbose ] [ --dry-run ] [ --git ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationFunctionRemove'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --dry-run ]'$'\e''[0m '$'\e''[[(blue)]m[ --git ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--verbose  '$'\e''[[(value)]mFlag. Optional. Use more words or phrases than absolutely essential.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--dry-run  '$'\e''[[(value)]mFlag. Optional. Do not do any thing, just say what would be done.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--git      '$'\e''[[(value)]mFlag. Remove from git.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove a function from the documentation cache'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''functionName - File with function names one per line.'
# shellcheck disable=SC2016
helpPlain='Usage: documentationFunctionRemove [ --verbose ] [ --dry-run ] [ --git ] [ --help ]'$'\n'''$'\n''    --verbose  Flag. Optional. Use more words or phrases than absolutely essential.'$'\n''    --dry-run  Flag. Optional. Do not do any thing, just say what would be done.'$'\n''    --git      Flag. Remove from git.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Remove a function from the documentation cache'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''functionName - File with function names one per line.'
documentationPath="documentation/source/tools/documentation.md"
