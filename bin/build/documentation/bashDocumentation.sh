#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="functionDefinitionFile - File. Required. The file in which the function is defined. If you don't know, use \`__bashDocumentation_FindFunctionDefinitions\` or \`__bashDocumentation_FindFunctionDefinition\`. (Both SLOW!)"$'\n'"functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"returnCode - Integer. Required. The return code to output."$'\n'"message - String. Optional. A message to output relating to the return code."$'\n'""
base="usage.sh"
build_debug="fast-usage - \`bashDocumentation\` does not output formatted help for performance reasons"$'\n'"usage-cache-skip - Skip all caching and generate from scratch"$'\n'"handler - For all \`--help\` and any function which uses \`usageTemplate\` to output documentation (upon error), the stack will be displayed"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Actual function is called \`{functionName}\`."$'\n'""$'\n'"Generates console usage output for a script using documentation tools parsed from the comment of the function identified."$'\n'""$'\n'"Simplifies documentation and keeps it with the code."$'\n'""$'\n'""
descriptionLineCount="6"
environment="BUILD_DEBUG"$'\n'""
example="goldenGoose() {"$'\n'"   local handler=\"_\${FUNCNAME[0]}\""$'\n'"   local home && home=\$(catchReturn \"\$handler\" buildHome) || return \$?"$'\n'"   ..."$'\n'"}"$'\n'"_goldenGoose() {"$'\n'"  bashDocumentation \"\${BASH_SOURCE[0]}\" \"\${FUNCNAME[0]#_}\" \"\$@\""$'\n'"}"$'\n'""
file="bin/build/tools/usage.sh"
fn="bashDocumentation"
fnMarker="bashdocumentation"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="environment" [4]="build_debug")
line="59"
rawComment="Summary: Universal function documentation"$'\n'"Actual function is called \`{functionName}\`."$'\n'"Argument: functionDefinitionFile - File. Required. The file in which the function is defined. If you don't know, use \`__bashDocumentation_FindFunctionDefinitions\` or \`__bashDocumentation_FindFunctionDefinition\`. (Both SLOW!)"$'\n'"Argument: functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"Argument: returnCode - Integer. Required. The return code to output."$'\n'"Argument: message - String. Optional. A message to output relating to the return code."$'\n'"Generates console usage output for a script using documentation tools parsed from the comment of the function identified."$'\n'"Simplifies documentation and keeps it with the code."$'\n'"Example: goldenGoose() {"$'\n'"Example:    local handler=\"_\${FUNCNAME[0]}\""$'\n'"Example:    local home && home=\$(catchReturn \"\$handler\" buildHome) || return \$?"$'\n'"Example:    ..."$'\n'"Example: }"$'\n'"Example: _goldenGoose() {"$'\n'"Example:   bashDocumentation \"\${BASH_SOURCE[0]}\" \"\${FUNCNAME[0]#_}\" \"\$@\""$'\n'"Example: }"$'\n'"Environment: BUILD_DEBUG"$'\n'"BUILD_DEBUG: fast-usage - \`bashDocumentation\` does not output formatted help for performance reasons"$'\n'"BUILD_DEBUG: usage-cache-skip - Skip all caching and generate from scratch"$'\n'"BUILD_DEBUG: handler - For all \`--help\` and any function which uses \`usageTemplate\` to output documentation (upon error), the stack will be displayed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="d422aa5ba72eb3aa919a918c054e1c085f507523"
sourceLine="59"
summary="Universal function documentation"
summaryComputed=""
usage="bashDocumentation functionDefinitionFile functionName returnCode [ message ]"
