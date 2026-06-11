#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-11
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Uses list of functions passed in \`stdin\`; using the \`SEE\` template."$'\n'"Output to \`allFunctionList.md\` typically."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/documentation.sh"
fn="bashDocumentationAllFunctions"
fnMarker="bashdocumentationallfunctions"
foundNames=([0]="summary" [1]="argument" [2]="stdin")
line="664"
rawComment="Summary: Generate markdown for a list of all functions"$'\n'"Uses list of functions passed in \`stdin\`; using the \`SEE\` template."$'\n'"Output to \`allFunctionList.md\` typically."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Function. Function names one per line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="27710a9141283b9bb677e2d559eed326e8761d6f"
sourceLine="664"
stdin="Function. Function names one per line."$'\n'""
summary="Generate markdown for a list of all functions"
summaryComputed=""
usage="bashDocumentationAllFunctions [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDocumentationAllFunctions'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Uses list of functions passed in '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m; using the '$'\e''[[(code)]mSEE'$'\e''[[(reset)]m template.'$'\n''Output to '$'\e''[[(code)]mallFunctionList.md'$'\e''[[(reset)]m typically.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Function. Function names one per line.'
# shellcheck disable=SC2016
helpPlain='Usage: bashDocumentationAllFunctions [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Uses list of functions passed in stdin; using the SEE template.'$'\n''Output to allFunctionList.md typically.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Function. Function names one per line.'
documentationPath="documentation/source/tools/documentation.md"
