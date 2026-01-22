#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"requiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"-- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment"$'\n'"optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not"$'\n'""
base="environment.sh"
description="Check application environment is populated correctly."$'\n'"Also verifies that \`environmentApplicationVariables\` and \`environmentApplicationLoad\` are defined."$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentFileApplicationVerify"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Check application environment is populated correctly."
usage="environmentFileApplicationVerify [ --help ] [ requiredEnvironment ... ] [ -- ] [ optionalEnvironment ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentFileApplicationVerify[0m [94m[ --help ][0m [94m[ requiredEnvironment ... ][0m [94m[ -- ][0m [94m[ optionalEnvironment ... ][0m

    [94m--help                   [1;97mFlag. Optional. Display this help.[0m
    [31mrequiredEnvironment ...  [1;97mEnvironmentName. Optional. One or more environment variables which should be non-blank and included in the [38;2;0;255;0;48;2;0;0;0m.env[0m file.[0m
    [31m--                       [1;97mDivider. Optional. Divides the requiredEnvironment values from the optionalEnvironment[0m
    [94moptionalEnvironment ...  [1;97mEnvironmentName. Optional. One or more environment variables which are included if blank or not[0m

Check application environment is populated correctly.
Also verifies that [38;2;0;255;0;48;2;0;0;0menvironmentApplicationVariables[0m and [38;2;0;255;0;48;2;0;0;0menvironmentApplicationLoad[0m are defined.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileApplicationVerify [ --help ] [ requiredEnvironment ... ] [ -- ] [ optionalEnvironment ... ]

    --help                   Flag. Optional. Display this help.
    requiredEnvironment ...  EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the .env file.
    --                       Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment
    optionalEnvironment ...  EnvironmentName. Optional. One or more environment variables which are included if blank or not

Check application environment is populated correctly.
Also verifies that environmentApplicationVariables and environmentApplicationLoad are defined.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
