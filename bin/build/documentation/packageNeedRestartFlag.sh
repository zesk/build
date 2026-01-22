#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="value - Set the restart flag to this value (blank to remove)"$'\n'""
base="package.sh"
description="INTERNAL - has \`packageUpdate\` set the \`restart\` flag at some point?"$'\n'""
file="bin/build/tools/package.sh"
fn="packageNeedRestartFlag"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="INTERNAL - has \`packageUpdate\` set the \`restart\` flag at some"
usage="packageNeedRestartFlag [ value ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageNeedRestartFlag[0m [94m[ value ][0m

    [94mvalue  [1;97mSet the restart flag to this value (blank to remove)[0m

INTERNAL - has [38;2;0;255;0;48;2;0;0;0mpackageUpdate[0m set the [38;2;0;255;0;48;2;0;0;0mrestart[0m flag at some point?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: packageNeedRestartFlag [ value ]

    value  Set the restart flag to this value (blank to remove)

INTERNAL - has packageUpdate set the restart flag at some point?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
