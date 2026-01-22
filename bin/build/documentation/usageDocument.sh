#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="functionDefinitionFile - File. Required. The file in which the function is defined. If you don't know, use \`__bashDocumentation_FindFunctionDefinitions\` or \`__bashDocumentation_FindFunctionDefinition\`."$'\n'"functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"exitCode - Integer. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"message - String. Optional. A message."$'\n'""
base="usage.sh"
build_debug="fast-usage - \`usageDocument\` does not output formatted help for performance reasons"$'\n'"handler - For all \`--help\` and any function which uses \`usageTemplate\` to output documentation (upon error), the stack will be displayed"$'\n'""
description="Actual function is called \`{functionName}\`."$'\n'""$'\n'""$'\n'"Generates console usage output for a script using documentation tools parsed from the comment of the function identified."$'\n'""$'\n'"Simplifies documentation and keeps it with the code."$'\n'""$'\n'""
environment="*BUILD_DEBUG* - Add \`fast-usage\` to make this quicker when you do not care about usage/failure."$'\n'""
file="bin/build/tools/usage.sh"
fn="usageDocument"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceModified="1769066861"
summary="Universal error handler for functions (with formatting)"$'\n'""
usage="usageDocument functionDefinitionFile functionName exitCode [ message ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255musageDocument[0m [38;2;255;255;0m[35;48;2;0;0;0mfunctionDefinitionFile[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfunctionName[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mexitCode[0m[0m [94m[ message ][0m

    [31mfunctionDefinitionFile  [1;97mFile. Required. The file in which the function is defined. If you don'\''t know, use [38;2;0;255;0;48;2;0;0;0m__bashDocumentation_FindFunctionDefinitions[0m or [38;2;0;255;0;48;2;0;0;0m__bashDocumentation_FindFunctionDefinition[0m.[0m
    [31mfunctionName            [1;97mString. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.[0m
    [31mexitCode                [1;97mInteger. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.[0m
    [94mmessage                 [1;97mString. Optional. A message.[0m

Actual function is called [38;2;0;255;0;48;2;0;0;0musageDocument[0m.


Generates console usage output for a script using documentation tools parsed from the comment of the function identified.

Simplifies documentation and keeps it with the code.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- [36mBUILD_DEBUG[0m - Add [38;2;0;255;0;48;2;0;0;0mfast-usage[0m to make this quicker when you do not care about usage/failure.
- 

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- fast-usage - [38;2;0;255;0;48;2;0;0;0musageDocument[0m does not output formatted help for performance reasons
- handler - For all [38;2;0;255;0;48;2;0;0;0m--help[0m and any function which uses [38;2;0;255;0;48;2;0;0;0musageTemplate[0m to output documentation (upon error), the stack will be displayed
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: usageDocument functionDefinitionFile functionName exitCode [ message ]

    functionDefinitionFile  File. Required. The file in which the function is defined. If you don'\''t know, use __bashDocumentation_FindFunctionDefinitions or __bashDocumentation_FindFunctionDefinition.
    functionName            String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
    exitCode                Integer. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
    message                 String. Optional. A message.

Actual function is called usageDocument.


Generates console usage output for a script using documentation tools parsed from the comment of the function identified.

Simplifies documentation and keeps it with the code.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG - Add fast-usage to make this quicker when you do not care about usage/failure.
- 

BUILD_DEBUG settings:
- fast-usage - usageDocument does not output formatted help for performance reasons
- handler - For all --help and any function which uses usageTemplate to output documentation (upon error), the stack will be displayed
- 
'
