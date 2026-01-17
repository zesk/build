#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="functionDefinitionFile -  File. Required. The file in which the function is defined. If you don't know, use \`__bashDocumentation_FindFunctionDefinitions\` or \`__bashDocumentation_FindFunctionDefinition\`."$'\n'"functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"exitCode -  Integer. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"message - String. Optional. A message."$'\n'""
base="usage.sh"
build_debug="fast-usage - \`usageDocument\` does not output formatted help for performance reasons"$'\n'"handler - For all \`--help\` and any function which uses \`usageTemplate\` to output documentation (upon error), the stack will be displayed"$'\n'""
description="Actual function is called \`{functionName}\`."$'\n'""$'\n'""$'\n'"Generates console usage output for a script using documentation tools parsed from the comment of the function identified."$'\n'""$'\n'"Simplifies documentation and keeps it with the code."$'\n'""$'\n'""
environment="*BUILD_DEBUG* - Add \`fast-usage\` to make this quicker when you do not care about usage/failure."$'\n'""
file="bin/build/tools/usage.sh"
fn="usageDocument"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="build_debug")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/usage.sh"
sourceModified="1768683999"
summary="Universal error handler for functions (with formatting)"$'\n'""
usage="usageDocument functionDefinitionFile functionName exitCode [ message ]"
