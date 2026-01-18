#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--env-file envFile - File. Optional.One (or more) environment files used during map of \`functionTemplate\`"$'\n'"functionName - Required. The function name to document."$'\n'"functionTemplate - Required. The template for individual functions."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="documentation.sh"
description="Requires function indexes to be generated in the documentation cache."$'\n'""$'\n'"Generate documentation for a single function."$'\n'""$'\n'"Template is output to stdout."$'\n'""$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationTemplateFunctionCompile"
foundNames=([0]="summary" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/documentation.sh"
sourceModified="1768695708"
summary="Generate a function documentation block using \`functionTemplate\` for \`functionName\`"$'\n'""
usage="documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]"
