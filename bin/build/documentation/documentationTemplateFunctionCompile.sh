#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--env-file envFile - File. Optional. One (or more) environment files used during map of \`functionTemplate\`"$'\n'"functionName - Required. The function name to document."$'\n'"functionTemplate - Required. The template for individual functions."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Requires function indexes to be generated in the documentation cache."$'\n'""$'\n'"Generate documentation for a single function."$'\n'""$'\n'"Template is output to stdout."$'\n'""$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationTemplateFunctionCompile"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1768842201"
summary="Generate a function documentation block using \`functionTemplate\` for \`functionName\`"$'\n'""
usage="documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdocumentationTemplateFunctionCompile[0m [94m[ --env-file envFile ][0m [38;2;255;255;0m[35;48;2;0;0;0mfunctionName[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfunctionTemplate[0m[0m [94m[ --help ][0m

    [94m--env-file envFile  [1;97mFile. Optional. One (or more) environment files used during map of [38;2;0;255;0;48;2;0;0;0mfunctionTemplate[0m[0m
    [31mfunctionName        [1;97mRequired. The function name to document.[0m
    [31mfunctionTemplate    [1;97mRequired. The template for individual functions.[0m
    [94m--help              [1;97mFlag. Optional. Display this help.[0m

Requires function indexes to be generated in the documentation cache.

Generate documentation for a single function.

Template is output to stdout.

Return Code: 0 - If success
Return Code: 1 - Issue with file generation
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]

    --env-file envFile  File. Optional. One (or more) environment files used during map of functionTemplate
    functionName        Required. The function name to document.
    functionTemplate    Required. The template for individual functions.
    --help              Flag. Optional. Display this help.

Requires function indexes to be generated in the documentation cache.

Generate documentation for a single function.

Template is output to stdout.

Return Code: 0 - If success
Return Code: 1 - Issue with file generation
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
