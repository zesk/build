#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decorate.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="decorate.sh"
description="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\` to calculate"$'\n'""$'\n'"Return Code: 0 - Console or output supports colors"$'\n'"Return Code: 1 - Colors are likely not supported by console"$'\n'""
environment="BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors."$'\n'""
file="bin/build/tools/decorate.sh"
fn="hasColors"
requires="isPositiveInteger tput"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate.sh"
sourceModified="1768721469"
summary="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\`"
usage="hasColors [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mhasColors[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Sets the environment variable [38;2;0;255;0;48;2;0;0;0mBUILD_COLORS[0m if not set, uses [38;2;0;255;0;48;2;0;0;0mTERM[0m to calculate

Return Code: 0 - Console or output supports colors
Return Code: 1 - Colors are likely not supported by console

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: hasColors [ --help ]

    --help  Flag. Optional. Display this help.

Sets the environment variable BUILD_COLORS if not set, uses TERM to calculate

Return Code: 0 - Console or output supports colors
Return Code: 1 - Colors are likely not supported by console

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.
- 
'
