#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="minimum - Integer|Empty. Minimum integer value to output."$'\n'"maximum - Integer|Empty. Maximum integer value to output."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Clamp digits between two integers"$'\n'"Reads stdin digits, one per line, and outputs only integer values between \$min and \$max"$'\n'""
file="bin/build/tools/colors.sh"
fn="clampDigits"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
summary="Clamp digits between two integers"
usage="clampDigits [ minimum ] [ maximum ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mclampDigits[0m [94m[ minimum ][0m [94m[ maximum ][0m [94m[ --help ][0m

    [94mminimum  [1;97mInteger|Empty. Minimum integer value to output.[0m
    [94mmaximum  [1;97mInteger|Empty. Maximum integer value to output.[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m

Clamp digits between two integers
Reads stdin digits, one per line, and outputs only integer values between $min and $max

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: clampDigits [ minimum ] [ maximum ] [ --help ]

    minimum  Integer|Empty. Minimum integer value to output.
    maximum  Integer|Empty. Maximum integer value to output.
    --help   Flag. Optional. Display this help.

Clamp digits between two integers
Reads stdin digits, one per line, and outputs only integer values between $min and $max

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
