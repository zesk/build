#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--any - Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist."$'\n'"binary ... - String. Required. One or more Binaries to find in the system \`PATH\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Return Code: 0 - If all values are found (without the \`--any\` flag), or if *any* binary is found with the \`--any\` flag"$'\n'"Return Code: 1 - If any value is not found (without the \`--any\` flag), or if *all* binaries are NOT found with the \`--any\` flag."$'\n'""
example="    whichExists cp date aws ls mv stat || throwEnvironment \"\$handler\" \"Need basic environment to work\" || return \$?"$'\n'"    whichExists --any terraform tofu || throwEnvironment \"\$handler\" \"No available infrastructure providers\" || return \$?"$'\n'"    whichExists --any curl wget || throwEnvironment \"\$handler\" \"No way to download URLs easily\" || return \$?"$'\n'""
file="bin/build/tools/platform.sh"
fn="whichExists"
foundNames=""
requires="throwArgument decorate __decorateExtensionEach command"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceModified="1769063211"
summary="Does a binary exist in the PATH?"$'\n'""
usage="whichExists [ --any ] binary ... [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mwhichExists[0m [94m[ --any ][0m [38;2;255;255;0m[35;48;2;0;0;0mbinary ...[0m[0m [94m[ --help ][0m

    [94m--any       [1;97mFlag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist.[0m
    [31mbinary ...  [1;97mString. Required. One or more Binaries to find in the system [38;2;0;255;0;48;2;0;0;0mPATH[0m.[0m
    [94m--help      [1;97mFlag. Optional. Display this help.[0m

Return Code: 0 - If all values are found (without the [38;2;0;255;0;48;2;0;0;0m--any[0m flag), or if [36many[0m binary is found with the [38;2;0;255;0;48;2;0;0;0m--any[0m flag
Return Code: 1 - If any value is not found (without the [38;2;0;255;0;48;2;0;0;0m--any[0m flag), or if [36mall[0m binaries are NOT found with the [38;2;0;255;0;48;2;0;0;0m--any[0m flag.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    whichExists cp date aws ls mv stat || throwEnvironment "$handler" "Need basic environment to work" || return $?
    whichExists --any terraform tofu || throwEnvironment "$handler" "No available infrastructure providers" || return $?
    whichExists --any curl wget || throwEnvironment "$handler" "No way to download URLs easily" || return $?
'
# shellcheck disable=SC2016
helpPlain='Usage: whichExists [ --any ] binary ... [ --help ]

    --any       Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist.
    binary ...  String. Required. One or more Binaries to find in the system PATH.
    --help      Flag. Optional. Display this help.

Return Code: 0 - If all values are found (without the --any flag), or if any binary is found with the --any flag
Return Code: 1 - If any value is not found (without the --any flag), or if all binaries are NOT found with the --any flag.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    whichExists cp date aws ls mv stat || throwEnvironment "$handler" "Need basic environment to work" || return $?
    whichExists --any terraform tofu || throwEnvironment "$handler" "No available infrastructure providers" || return $?
    whichExists --any curl wget || throwEnvironment "$handler" "No way to download URLs easily" || return $?
'
