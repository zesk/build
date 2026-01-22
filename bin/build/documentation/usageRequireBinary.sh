#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"binary - Required. Binary which must have a \`which\` path."$'\n'""
base="usage.sh"
description="Return Code: 1 - If any \`binary\` is not available within the current path"$'\n'"Requires the binaries to be found via \`which\`"$'\n'""$'\n'"Runs \`handler\` on failure"$'\n'""$'\n'""
file="bin/build/tools/usage.sh"
fn="usageRequireBinary"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceModified="1768721469"
summary="Check that one or more binaries are installed"$'\n'""
usage="usageRequireBinary usageFunction binary"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255musageRequireBinary[0m [38;2;255;255;0m[35;48;2;0;0;0musageFunction[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mbinary[0m[0m

    [31musageFunction  [1;97mRequired. [38;2;0;255;0;48;2;0;0;0mbash[0m function already defined to output handler[0m
    [31mbinary         [1;97mRequired. Binary which must have a [38;2;0;255;0;48;2;0;0;0mwhich[0m path.[0m

Return Code: 1 - If any [38;2;0;255;0;48;2;0;0;0mbinary[0m is not available within the current path
Requires the binaries to be found via [38;2;0;255;0;48;2;0;0;0mwhich[0m

Runs [38;2;0;255;0;48;2;0;0;0mhandler[0m on failure

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: usageRequireBinary usageFunction binary

    usageFunction  Required. bash function already defined to output handler
    binary         Required. Binary which must have a which path.

Return Code: 1 - If any binary is not available within the current path
Requires the binaries to be found via which

Runs handler on failure

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
