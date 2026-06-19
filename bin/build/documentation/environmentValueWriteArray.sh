#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nvalue ... - Arguments. Optional. Array values as arguments.\n--help - Flag. Optional. Display this help.\n'
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Write an array value as NAME=([0]="a" [1]="b" [2]="c")\nSupports empty arrays\nBash outputs on different versions:\n\n    declare -a foo=\'([0]="a" [1]="b" [2]="c")\'\n    declare -a foo=([0]="a" [1]="b" [2]="c")\n\n'
descriptionLineCount="7"
file="bin/build/tools/environment/io.sh"
fn="environmentValueWriteArray"
fnMarker="environmentvaluewritearray"
foundNames=([0]="argument")
line="47"
rawComment=$'Write an array value as NAME=([0]="a" [1]="b" [2]="c")\nSupports empty arrays\nBash outputs on different versions:\n    declare -a foo=\'([0]="a" [1]="b" [2]="c")\'\n    declare -a foo=([0]="a" [1]="b" [2]="c")\nArgument: --help - Flag. Optional. Display this help.\nArgument: value ... - Arguments. Optional. Array values as arguments.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="565ea7df1e58c04e83b459faee071a3b938bd9d4"
sourceLine="47"
summary="Write an array value as NAME=([0]=\"a\" [1]=\"b\" [2]=\"c\")"
summaryComputed="true"
usage="environmentValueWriteArray [ --help ] [ value ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueWriteArray'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ value ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue ...  '$'\e''[[(value)]mArguments. Optional. Array values as arguments.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Write an array value as NAME=([0]="a" [1]="b" [2]="c")'$'\n''Supports empty arrays'$'\n''Bash outputs on different versions:'$'\n'''$'\n''    declare -a foo='\''([0]="a" [1]="b" [2]="c")'\'''$'\n''    declare -a foo=([0]="a" [1]="b" [2]="c")'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueWriteArray [ --help ] [ value ... ] [ --help ]'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    value ...  Arguments. Optional. Array values as arguments.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Write an array value as NAME=([0]="a" [1]="b" [2]="c")'$'\n''Supports empty arrays'$'\n''Bash outputs on different versions:'$'\n'''$'\n''    declare -a foo='\''([0]="a" [1]="b" [2]="c")'\'''$'\n''    declare -a foo=([0]="a" [1]="b" [2]="c")'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/environment.md"
