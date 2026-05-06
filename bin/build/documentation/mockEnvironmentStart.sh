#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="globalName - EnvironmentVariable. Required. Global to change temporarily to a value."$'\n'"value - EmptyString. Optional. Force the value of \`globalName\` to this value temporarily. Saves the original value."$'\n'"... - Continue passing pairs of globalName value to mock additional values."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fake a value for testing"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/test.sh"
fn="mockEnvironmentStart"
fnMarker="mockenvironmentstart"
foundNames=([0]="argument")
line="1440"
rawComment="Fake a value for testing"$'\n'"Argument: globalName - EnvironmentVariable. Required. Global to change temporarily to a value."$'\n'"Argument: value - EmptyString. Optional. Force the value of \`globalName\` to this value temporarily. Saves the original value."$'\n'"Argument: ... - Continue passing pairs of globalName value to mock additional values."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="78c7da5cbc1777fd8206d96854e19720ad1957a9"
sourceLine="1440"
summary="Fake a value for testing"
summaryComputed="true"
usage="mockEnvironmentStart globalName [ value ] [ ... ] [ --help ]"
