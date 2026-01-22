#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"environmentVariable - String. Optional. One or more environment variables which should be set and non-empty."$'\n'""
base="usage.sh"
deprecated="2024-01-01"$'\n'""
description="Requires environment variables to be set and non-blank"$'\n'"Return Code: 0 - All environment variables are set and non-empty"$'\n'"Return Code: 1 - If any \`environmentVariable\` variables are not set or are empty."$'\n'""$'\n'""
file="bin/build/tools/usage.sh"
fn="usageRequireEnvironment"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceModified="1768721469"
summary="Requires environment variables to be set and non-blank"
usage="usageRequireEnvironment usageFunction [ environmentVariable ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255musageRequireEnvironment[0m [38;2;255;255;0m[35;48;2;0;0;0musageFunction[0m[0m [94m[ environmentVariable ][0m

    [31musageFunction        [1;97mRequired. [38;2;0;255;0;48;2;0;0;0mbash[0m function already defined to output handler[0m
    [94menvironmentVariable  [1;97mString. Optional. One or more environment variables which should be set and non-empty.[0m

Requires environment variables to be set and non-blank
Return Code: 0 - All environment variables are set and non-empty
Return Code: 1 - If any [38;2;0;255;0;48;2;0;0;0menvironmentVariable[0m variables are not set or are empty.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: usageRequireEnvironment usageFunction [ environmentVariable ]

    usageFunction        Required. bash function already defined to output handler
    environmentVariable  String. Optional. One or more environment variables which should be set and non-empty.

Requires environment variables to be set and non-blank
Return Code: 0 - All environment variables are set and non-empty
Return Code: 1 - If any environmentVariable variables are not set or are empty.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
