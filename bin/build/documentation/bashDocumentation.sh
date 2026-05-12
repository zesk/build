#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'functionDefinitionFile - File. Required. The file in which the function is defined. If you don\'t know, use `__bashDocumentation_FindFunctionDefinitions` or `__bashDocumentation_FindFunctionDefinition`. (Both SLOW!)\nfunctionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.\nreturnCode - Integer. Required. The return code to output.\nmessage - String. Optional. A message to output relating to the return code.\n'
base="usage.sh"
build_debug=$'fast-usage - `bashDocumentation` does not output formatted help for performance reasons\nusage-cache-skip - Skip all caching and generate from scratch\nhandler - For all `--help` and any function which uses `usageTemplate` to output documentation (upon error), the stack will be displayed\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Actual function is called `{functionName}`.\n\nGenerates console usage output for a script using documentation tools parsed from the comment of the function identified.\n\nSimplifies documentation and keeps it with the code.\n\n'
descriptionLineCount="6"
environment=$'BUILD_DEBUG\n'
example=$'goldenGoose() {\n   local handler="_${FUNCNAME[0]}"\n   local home && home=$(catchReturn "$handler" buildHome) || return $?\n   ...\n}\n_goldenGoose() {\n  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"\n}\n'
file="bin/build/tools/usage.sh"
fn="bashDocumentation"
fnMarker="bashdocumentation"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="environment" [4]="build_debug")
line="59"
rawComment=$'Summary: Universal function documentation\nActual function is called `{functionName}`.\nArgument: functionDefinitionFile - File. Required. The file in which the function is defined. If you don\'t know, use `__bashDocumentation_FindFunctionDefinitions` or `__bashDocumentation_FindFunctionDefinition`. (Both SLOW!)\nArgument: functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.\nArgument: returnCode - Integer. Required. The return code to output.\nArgument: message - String. Optional. A message to output relating to the return code.\nGenerates console usage output for a script using documentation tools parsed from the comment of the function identified.\nSimplifies documentation and keeps it with the code.\nExample: goldenGoose() {\nExample:    local handler="_${FUNCNAME[0]}"\nExample:    local home && home=$(catchReturn "$handler" buildHome) || return $?\nExample:    ...\nExample: }\nExample: _goldenGoose() {\nExample:   bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"\nExample: }\nEnvironment: BUILD_DEBUG\nBUILD_DEBUG: fast-usage - `bashDocumentation` does not output formatted help for performance reasons\nBUILD_DEBUG: usage-cache-skip - Skip all caching and generate from scratch\nBUILD_DEBUG: handler - For all `--help` and any function which uses `usageTemplate` to output documentation (upon error), the stack will be displayed\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/usage.sh"
sourceHash="3291d7e64ccb36a84b9d6875ccfaa2cae11670fd"
sourceLine="59"
summary="Universal function documentation"
summaryComputed=""
usage="bashDocumentation functionDefinitionFile functionName returnCode [ message ]"
