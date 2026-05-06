#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--reset - Flag. Optional. Reset statistics to zero."$'\n'"--total - Flag. Optional. Just output the total."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline"$'\n'""$'\n'""
descriptionLineCount="2"
example="    read -r failures successes < <(assertStatistics) || return \$?"$'\n'""
file="bin/build/tools/test.sh"
fn="assertStatistics"
fnMarker="assertstatistics"
foundNames=([0]="summary" [1]="argument" [2]="stdout" [3]="example")
line="117"
rawComment="Summary: Output assertion counts"$'\n'"Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline"$'\n'"Argument: --reset - Flag. Optional. Reset statistics to zero."$'\n'"Argument: --total - Flag. Optional. Just output the total."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: UnsignedInteger. 2 lines."$'\n'"Example:     read -r failures successes < <({fn}) || return \$?"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="78c7da5cbc1777fd8206d96854e19720ad1957a9"
sourceLine="117"
stdout="UnsignedInteger. 2 lines."$'\n'""
summary="Output assertion counts"
summaryComputed=""
usage="assertStatistics [ --reset ] [ --total ] [ --help ]"
