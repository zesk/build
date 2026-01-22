#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="environmentName - EnvironmentVariable. Optional. A required environment variable name"$'\n'"-- - Separator. Optional. Separates requires from optional environment variables"$'\n'"optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name."$'\n'""
base="environment.sh"
description="Display and validate application variables."$'\n'"Return Code: 1 - If any required application variables are blank, the function fails with an environment error"$'\n'"Return Code: 0 - All required application variables are non-blank"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentFileShow"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769063211"
summary="Display and validate application variables."
usage="environmentFileShow [ environmentName ] [ -- ] [ optionalEnvironmentName ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentFileShow[0m [94m[ environmentName ][0m [94m[ -- ][0m [94m[ optionalEnvironmentName ][0m

    [31menvironmentName          [1;97mEnvironmentVariable. Optional. A required environment variable name[0m
    [94m--                       [1;97mSeparator. Optional. Separates requires from optional environment variables[0m
    [94moptionalEnvironmentName  [1;97mEnvironmentVariable. Optional. An optional environment variable name.[0m

Display and validate application variables.
Return Code: 1 - If any required application variables are blank, the function fails with an environment error
Return Code: 0 - All required application variables are non-blank

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileShow [ environmentName ] [ -- ] [ optionalEnvironmentName ]

    environmentName          EnvironmentVariable. Optional. A required environment variable name
    --                       Separator. Optional. Separates requires from optional environment variables
    optionalEnvironmentName  EnvironmentVariable. Optional. An optional environment variable name.

Display and validate application variables.
Return Code: 1 - If any required application variables are blank, the function fails with an environment error
Return Code: 0 - All required application variables are non-blank

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
