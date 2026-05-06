#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
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
line="247"
rawComment="Summary: Generate a function documentation block using \`functionTemplate\` for \`functionName\`"$'\n'"Requires function indexes to be generated in the documentation cache."$'\n'"Generate documentation for a single function."$'\n'"Template is output to stdout."$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'"Argument: --env-file envFile - File. Optional. One (or more) environment files used during map of \`functionTemplate\`"$'\n'"Argument: functionName - Required. The function name to document."$'\n'"Argument: functionTemplate - Required. The template for individual functions."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - If success"$'\n'"1 - Issue with file generation"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="7487e1e4be50d4eb634f007bfd41adda45ab6d68"
sourceLine="247"
summary="Generate a function documentation block using \`functionTemplate\` for \`functionName\`"
summaryComputed=""
usage="documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]"
