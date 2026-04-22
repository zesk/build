#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"binary - Callable. Required. Command to run."$'\n'"... - Arguments. Optional. Any arguments are passed to \`binary\`."$'\n'""
base="_sugar.sh"
description="Run binary and output failed command upon error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="execute"
foundNames=([0]="argument" [1]="requires")
line="139"
lowerFn="execute"
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: binary - Callable. Required. Command to run."$'\n'"Argument: ... - Arguments. Optional. Any arguments are passed to \`binary\`."$'\n'"Run binary and output failed command upon error"$'\n'"Requires: returnMessage helpArgument"$'\n'""$'\n'""
requires="returnMessage helpArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="1cf1ee5794e801d06a483b8f311df83c051c18a0"
sourceLine="139"
summary="Run binary and output failed command upon error"
summaryComputed="true"
usage="execute [ --help ] binary [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecute'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mbinary  '$'\e''[[(value)]mCallable. Required. Command to run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mArguments. Optional. Any arguments are passed to '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Run binary and output failed command upon error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: execute [ --help ] binary [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    binary  Callable. Required. Command to run.'$'\n''    ...     Arguments. Optional. Any arguments are passed to binary.'$'\n'''$'\n''Run binary and output failed command upon error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/sugar-core.md"
