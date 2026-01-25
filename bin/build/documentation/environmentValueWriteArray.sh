#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"value ... - Arguments. Optional. Array values as arguments."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Write an array value as NAME=([0]=\"a\" [1]=\"b\" [2]=\"c\")"$'\n'"Supports empty arrays"$'\n'"Bash outputs on different versions:"$'\n'"    declare -a foo='([0]=\"a\" [1]=\"b\" [2]=\"c\")'"$'\n'"    declare -a foo=([0]=\"a\" [1]=\"b\" [2]=\"c\")"$'\n'""
exitCode="0"
file="bin/build/tools/environment.sh"
rawComment="Write an array value as NAME=([0]=\"a\" [1]=\"b\" [2]=\"c\")"$'\n'"Supports empty arrays"$'\n'"Bash outputs on different versions:"$'\n'"    declare -a foo='([0]=\"a\" [1]=\"b\" [2]=\"c\")'"$'\n'"    declare -a foo=([0]=\"a\" [1]=\"b\" [2]=\"c\")"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value ... - Arguments. Optional. Array values as arguments."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769320208"
summary="Write an array value as NAME=([0]=\"a\" [1]=\"b\" [2]=\"c\")"
usage="environmentValueWriteArray [ --help ] [ value ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]menvironmentValueWriteArray'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ value ... ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help     '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mvalue ...  '$'\e''[[value]mArguments. Optional. Array values as arguments.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help     '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Write an array value as NAME=([0]="a" [1]="b" [2]="c")'$'\n''Supports empty arrays'$'\n''Bash outputs on different versions:'$'\n''    declare -a foo='\''([0]="a" [1]="b" [2]="c")'\'''$'\n''    declare -a foo=([0]="a" [1]="b" [2]="c")'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueWriteArray [ --help ] [ value ... ] [ --help ]'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    value ...  Arguments. Optional. Array values as arguments.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Write an array value as NAME=([0]="a" [1]="b" [2]="c")'$'\n''Supports empty arrays'$'\n''Bash outputs on different versions:'$'\n''    declare -a foo='\''([0]="a" [1]="b" [2]="c")'\'''$'\n''    declare -a foo=([0]="a" [1]="b" [2]="c")'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
