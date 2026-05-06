#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Parse variables from an environment variable stream"$'\n'""$'\n'"Extracts lines with \`NAME=value\`"$'\n'""$'\n'"Details:"$'\n'"- Remove \`export \` from lines"$'\n'"- Skip lines containing \`read -r\`"$'\n'"- Anything before a \`=\` is considered a variable name"$'\n'"- Returns a sorted, unique list"$'\n'""$'\n'""
descriptionLineCount="10"
file="bin/build/tools/environment.sh"
fn="environmentParseVariables"
fnMarker="environmentparsevariables"
foundNames=([0]="stdin" [1]="stdout" [2]="argument")
line="156"
rawComment="Parse variables from an environment variable stream"$'\n'"Extracts lines with \`NAME=value\`"$'\n'"Details:"$'\n'"- Remove \`export \` from lines"$'\n'"- Skip lines containing \`read -r\`"$'\n'"- Anything before a \`=\` is considered a variable name"$'\n'"- Returns a sorted, unique list"$'\n'"stdin: Environment File"$'\n'"stdout: EnvironmentVariable. One per line."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="fd4da5f1d9a2c52100a1a281185a474bae9aba02"
sourceLine="156"
stdin="Environment File"$'\n'""
stdout="EnvironmentVariable. One per line."$'\n'""
summary="Parse variables from an environment variable stream"
summaryComputed="true"
usage="environmentParseVariables [ --help ]"
