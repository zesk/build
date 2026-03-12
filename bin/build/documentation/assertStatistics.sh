#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--reset - Flag. Optional. Reset statistics to zero."$'\n'"--total - Flag. Optional. Just output the total."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="test.sh"
description="Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline"$'\n'""
example="    read -r failures successes < <(assertStatistics) || return \$?"$'\n'""
file="bin/build/tools/test.sh"
fn="assertStatistics"
foundNames=([0]="summary" [1]="argument" [2]="stdout" [3]="example")
rawComment="Summary: Output assertion counts"$'\n'"Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline"$'\n'"Argument: --reset - Flag. Optional. Reset statistics to zero."$'\n'"Argument: --total - Flag. Optional. Just output the total."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: UnsignedInteger. 2 lines."$'\n'"Example:     read -r failures successes < <({fn}) || return \$?"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="3dc9153efc63a64f4b122dfeb5c5c0343dd405ee"
stdout="UnsignedInteger. 2 lines."$'\n'""
summary="Output assertion counts"$'\n'""
usage="assertStatistics [ --reset ] [ --total ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
