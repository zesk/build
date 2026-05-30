#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-27
# shellcheck disable=SC2034
argument=$'--env-file envFile - File. Optional. One (or more) environment files used during map of `functionTemplate`\nfunctionName - Required. The function name to document.\nfunctionTemplate - Required. The template for individual functions.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Requires function indexes to be generated in the documentation cache.\n\nGenerate documentation for a single function.\n\nTemplate is output to stdout.\n\n'
descriptionLineCount="6"
file="bin/build/tools/documentation.sh"
fn="documentationTemplateFunctionCompile"
fnMarker="documentationtemplatefunctioncompile"
foundNames=([0]="summary" [1]="return_code" [2]="argument")
line="247"
rawComment=$'Summary: Generate a function documentation block using `functionTemplate` for `functionName`\nRequires function indexes to be generated in the documentation cache.\nGenerate documentation for a single function.\nTemplate is output to stdout.\nReturn Code: 0 - If success\nReturn Code: 1 - Issue with file generation\nReturn Code: 2 - Argument error\nArgument: --env-file envFile - File. Optional. One (or more) environment files used during map of `functionTemplate`\nArgument: functionName - Required. The function name to document.\nArgument: functionTemplate - Required. The template for individual functions.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - If success\n1 - Issue with file generation\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="1c8f55384c305516f36c332ab5bcba79217a4ef6"
sourceLine="247"
summary="Generate a function documentation block using \`functionTemplate\` for \`functionName\`"
summaryComputed=""
usage="documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationTemplateFunctionCompile'$'\e''[0m '$'\e''[[(blue)]m[ --env-file envFile ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionTemplate'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--env-file envFile  '$'\e''[[(value)]mFile. Optional. One (or more) environment files used during map of '$'\e''[[(code)]mfunctionTemplate'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionName        '$'\e''[[(value)]mRequired. The function name to document.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunctionTemplate    '$'\e''[[(value)]mRequired. The template for individual functions.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help              '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Requires function indexes to be generated in the documentation cache.'$'\n'''$'\n''Generate documentation for a single function.'$'\n'''$'\n''Template is output to stdout.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Issue with file generation'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]'$'\n'''$'\n''    --env-file envFile  File. Optional. One (or more) environment files used during map of functionTemplate'$'\n''    functionName        Required. The function name to document.'$'\n''    functionTemplate    Required. The template for individual functions.'$'\n''    --help              Flag. Optional. Display this help.'$'\n'''$'\n''Requires function indexes to be generated in the documentation cache.'$'\n'''$'\n''Generate documentation for a single function.'$'\n'''$'\n''Template is output to stdout.'$'\n'''$'\n''Return codes:'$'\n''- 0 - If success'$'\n''- 1 - Issue with file generation'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
