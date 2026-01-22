#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"requiredVariable ... - EnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"-- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once."$'\n'"optionalVariable ... - EnvironmentVariable. Optional. One or more environment variables which are included if blank or not"$'\n'""
base="environment.sh"
description="Create environment file \`.env\` for build."$'\n'""$'\n'"Note that this does NOT change or modify the current environment."$'\n'""$'\n'""
environment="APPLICATION_VERSION - reserved and set to \`hookRun version-current\` if not set already"$'\n'"APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL."$'\n'"APPLICATION_TAG - reserved and set to \`hookRun application-id\`"$'\n'"APPLICATION_ID - reserved and set to \`hookRun application-tag\`"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentFileApplicationMake"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769055842"
summary="Create environment file \`.env\` for build."
usage="environmentFileApplicationMake [ --help ] [ requiredVariable ... ] [ -- ] [ optionalVariable ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentFileApplicationMake[0m [94m[ --help ][0m [94m[ requiredVariable ... ][0m [94m[ -- ][0m [94m[ optionalVariable ... ][0m

    [94m--help                [1;97mFlag. Optional. Display this help.[0m
    [31mrequiredVariable ...  [1;97mEnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the [38;2;0;255;0;48;2;0;0;0m.env[0m file.[0m
    [31m--                    [1;97mDivider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once.[0m
    [94moptionalVariable ...  [1;97mEnvironmentVariable. Optional. One or more environment variables which are included if blank or not[0m

Create environment file [38;2;0;255;0;48;2;0;0;0m.env[0m for build.

Note that this does NOT change or modify the current environment.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- APPLICATION_VERSION - reserved and set to [38;2;0;255;0;48;2;0;0;0mhookRun version-current[0m if not set already
- APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
- APPLICATION_TAG - reserved and set to [38;2;0;255;0;48;2;0;0;0mhookRun application-id[0m
- APPLICATION_ID - reserved and set to [38;2;0;255;0;48;2;0;0;0mhookRun application-tag[0m
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileApplicationMake [ --help ] [ requiredVariable ... ] [ -- ] [ optionalVariable ... ]

    --help                Flag. Optional. Display this help.
    requiredVariable ...  EnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the .env file.
    --                    Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once.
    optionalVariable ...  EnvironmentVariable. Optional. One or more environment variables which are included if blank or not

Create environment file .env for build.

Note that this does NOT change or modify the current environment.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- APPLICATION_VERSION - reserved and set to hookRun version-current if not set already
- APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
- APPLICATION_TAG - reserved and set to hookRun application-id
- APPLICATION_ID - reserved and set to hookRun application-tag
- 
'
