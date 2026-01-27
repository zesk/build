#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="text - EmptyString. Required. Text to quote."$'\n'""
base="quote.sh"
depends="sed"$'\n'""
description="Quote bash strings for inclusion as single-quoted for eval"$'\n'""
example="    name=\"\$(quoteBashString \"\$name\")\""$'\n'""
file="bin/build/tools/quote.sh"
foundNames=([0]="argument" [1]="output" [2]="depends" [3]="example")
output="string quoted and appropriate to assign to a value in the shell"$'\n'""
rawComment="Quote bash strings for inclusion as single-quoted for eval"$'\n'"Argument: text - EmptyString. Required. Text to quote."$'\n'"Output: string quoted and appropriate to assign to a value in the shell"$'\n'"Depends: sed"$'\n'"Example:     name=\"\$(quoteBashString \"\$name\")\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceModified="1769063211"
summary="Quote bash strings for inclusion as single-quoted for eval"
usage="quoteBashString text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mquoteBashString'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtext  '$'\e''[[(value)]mEmptyString. Required. Text to quote.'$'\e''[[(reset)]m'$'\n'''$'\n''Quote bash strings for inclusion as single-quoted for eval'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    name="$(quoteBashString "$name")"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: quoteBashString text'$'\n'''$'\n''    text  EmptyString. Required. Text to quote.'$'\n'''$'\n''Quote bash strings for inclusion as single-quoted for eval'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    name="$(quoteBashString "$name")"'$'\n'''
# elapsed 0.435
