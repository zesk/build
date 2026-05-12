#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
sourceHash="0134555ea1c32d02fdc40fd9058827a280501390"
sourceLine="247"
summary="Generate a function documentation block using \`functionTemplate\` for \`functionName\`"
summaryComputed=""
usage="documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]"
