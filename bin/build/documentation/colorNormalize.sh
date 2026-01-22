#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Redistribute color values to make brightness adjustments more balanced"$'\n'""
file="bin/build/tools/colors.sh"
fn="colorNormalize"
foundNames=""
requires="bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
summary="Redistribute color values to make brightness adjustments more balanced"
usage="colorNormalize [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcolorNormalize[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Redistribute color values to make brightness adjustments more balanced

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: colorNormalize [ --help ]

    --help  Flag. Optional. Display this help.

Redistribute color values to make brightness adjustments more balanced

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
