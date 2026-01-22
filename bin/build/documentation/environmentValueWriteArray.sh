#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"value ... - Arguments. Optional. Array values as arguments."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Write an array value as NAME=([0]=\"a\" [1]=\"b\" [2]=\"c\")"$'\n'"Supports empty arrays"$'\n'"Bash outputs on different versions:"$'\n'""$'\n'"    declare -a foo='([0]=\"a\" [1]=\"b\" [2]=\"c\")'"$'\n'"    declare -a foo=([0]=\"a\" [1]=\"b\" [2]=\"c\")"$'\n'""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentValueWriteArray"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769063211"
summary="Write an array value as NAME=([0]=\"a\" [1]=\"b\" [2]=\"c\")"
usage="environmentValueWriteArray [ --help ] [ value ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentValueWriteArray[0m [94m[ --help ][0m [94m[ value ... ][0m [94m[ --help ][0m

    [94m--help     [1;97mFlag. Optional. Display this help.[0m
    [94mvalue ...  [1;97mArguments. Optional. Array values as arguments.[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Write an array value as NAME=([0]="a" [1]="b" [2]="c")
Supports empty arrays
Bash outputs on different versions:

    declare -a foo='\''([0]="a" [1]="b" [2]="c")'\''
    declare -a foo=([0]="a" [1]="b" [2]="c")

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueWriteArray [ --help ] [ value ... ] [ --help ]

    --help     Flag. Optional. Display this help.
    value ...  Arguments. Optional. Array values as arguments.
    --help     Flag. Optional. Display this help.

Write an array value as NAME=([0]="a" [1]="b" [2]="c")
Supports empty arrays
Bash outputs on different versions:

    declare -a foo='\''([0]="a" [1]="b" [2]="c")'\''
    declare -a foo=([0]="a" [1]="b" [2]="c")

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
