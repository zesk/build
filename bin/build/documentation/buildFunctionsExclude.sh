#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Removes any function from the text stream which is in \`buildFunctions\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="buildFunctionsExclude"
fnMarker="buildfunctionsexclude"
foundNames=([0]="summary" [1]="stdin" [2]="stdout" [3]="argument")
line="130"
rawComment="Summary: Exclude any function which is a build function"$'\n'"Removes any function from the text stream which is in \`buildFunctions\`"$'\n'"stdin: line:Function"$'\n'"stdout: line:Function"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="7c3aa107c357db74a0d854defdaf7f2b17361d34"
sourceLine="130"
stdin="line:Function"$'\n'""
stdout="line:Function"$'\n'""
summary="Exclude any function which is a build function"
summaryComputed=""
usage="buildFunctionsExclude [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildFunctionsExclude'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Removes any function from the text stream which is in '$'\e''[[(code)]mbuildFunctions'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''line:Function'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''line:Function'
# shellcheck disable=SC2016
helpPlain='Usage: buildFunctionsExclude [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Removes any function from the text stream which is in buildFunctions'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''line:Function'$'\n'''$'\n''Writes to stdout:'$'\n''line:Function'
documentationPath="documentation/source/tools/build.md"
