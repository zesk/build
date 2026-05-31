#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-31
# shellcheck disable=SC2034
argument="--env-file envFile - File. Optional. One (or more) environment files used during map of \`functionTemplate\`"$'\n'"functionName - Required. The function name to document."$'\n'"functionTemplate - Required. The template for individual functions."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Requires function indexes to be generated in the documentation cache."$'\n'""$'\n'"Generate documentation for a single function."$'\n'""$'\n'"Template is output to stdout."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/documentation.sh"
fn="documentationTemplateFunctionCompile"
fnMarker="documentationtemplatefunctioncompile"
foundNames=([0]="summary" [1]="return_code" [2]="argument")
line="259"
rawComment="Summary: Generate a function documentation block using \`functionTemplate\` for \`functionName\`"$'\n'"Requires function indexes to be generated in the documentation cache."$'\n'"Generate documentation for a single function."$'\n'"Template is output to stdout."$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'"Argument: --env-file envFile - File. Optional. One (or more) environment files used during map of \`functionTemplate\`"$'\n'"Argument: functionName - Required. The function name to document."$'\n'"Argument: functionTemplate - Required. The template for individual functions."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - If success"$'\n'"1 - Issue with file generation"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="0d90e647b7790474ad3a3c64db34d327f5438242"
sourceLine="259"
summary="Generate a function documentation block using \`functionTemplate\` for \`functionName\`"
summaryComputed=""
usage="documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationTemplateFunctionCompile'$'\e''[0m '$'\e''[[(blue)]m[ --env-file envFile ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionTemplate'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--env-file envFile  '$'\e''[[(value)]mFile. Optional. One (or more) environment files used during map of '$'\e''[[(code)]mfunctionTemplate'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionName        '$'\e''[[(value)]mRequired. The function name to document.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionTemplate    '$'\e''[[(value)]mRequired. The template for individual functions.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help              '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Requires function indexes to be generated in the documentation cache.'$'\n'''$'\n''Generate documentation for a single function.'$'\n'''$'\n''Template is output to stdout.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Issue with file generation'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]'$'\n'''$'\n''    --env-file envFile  File. Optional. One (or more) environment files used during map of functionTemplate'$'\n''    functionName        Required. The function name to document.'$'\n''    functionTemplate    Required. The template for individual functions.'$'\n''    --help              Flag. Optional. Display this help.'$'\n'''$'\n''Requires function indexes to be generated in the documentation cache.'$'\n'''$'\n''Generate documentation for a single function.'$'\n'''$'\n''Template is output to stdout.'$'\n'''$'\n''Return codes:'$'\n''- 0 - If success'$'\n''- 1 - Issue with file generation'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
