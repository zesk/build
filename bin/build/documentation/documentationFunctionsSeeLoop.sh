#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\npath - Directory. Required. The documentation path to examine.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Runs an infinite loop in the console until there are zero unresolved `SEE:` tokens in the documentation path.\nSearches Markdown (`.md`) files a single level deep.\nYou can fix tokens by running `documentationFunctionsCompile` or building the documentation which usually updates environment templates.\nDelays 10 seconds between checks.\n\n'
descriptionLineCount="5"
file="bin/build/tools/documentation.sh"
fn="documentationFunctionsSeeLoop"
fnMarker="documentationfunctionsseeloop"
foundNames=([0]="summary" [1]="argument")
line="984"
original="documentationFunctionsSeeLoop"
rawComment=$'Summary: Interactively watch count of unresolved `SEE:` tokens in documentation\nRuns an infinite loop in the console until there are zero unresolved `SEE:` tokens in the documentation path.\nSearches Markdown (`.md`) files a single level deep.\nYou can fix tokens by running `documentationFunctionsCompile` or building the documentation which usually updates environment templates.\nDelays 10 seconds between checks.\nArgument: --help - Flag. Optional. Display this help.\nArgument: path - Directory. Required. The documentation path to examine.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="d51e4672057607172307c44e6065c356ed05ce35"
sourceLine="984"
summary="Interactively watch count of unresolved \`SEE:\` tokens in documentation"
summaryComputed=""
usage="documentationFunctionsSeeLoop [ --help ] path"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationFunctionsSeeLoop'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpath    '$'\e''[[(value)]mDirectory. Required. The documentation path to examine.'$'\e''[[(reset)]m'$'\n'''$'\n''Runs an infinite loop in the console until there are zero unresolved '$'\e''[[(code)]mSEE:'$'\e''[[(reset)]m tokens in the documentation path.'$'\n''Searches Markdown ('$'\e''[[(code)]m.md'$'\e''[[(reset)]m) files a single level deep.'$'\n''You can fix tokens by running '$'\e''[[(code)]mdocumentationFunctionsCompile'$'\e''[[(reset)]m or building the documentation which usually updates environment templates.'$'\n''Delays 10 seconds between checks.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationFunctionsSeeLoop [ --help ] path'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    path    Directory. Required. The documentation path to examine.'$'\n'''$'\n''Runs an infinite loop in the console until there are zero unresolved SEE: tokens in the documentation path.'$'\n''Searches Markdown (.md) files a single level deep.'$'\n''You can fix tokens by running documentationFunctionsCompile or building the documentation which usually updates environment templates.'$'\n''Delays 10 seconds between checks.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
