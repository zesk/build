#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nbinary - Callable. Required. Command to run.\n... - Arguments. Optional. Any arguments are passed to `binary`.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run binary and output failed command upon error\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="execute"
fnMarker="execute"
foundNames=([0]="argument" [1]="requires")
line="140"
rawComment=$'Argument: --help - Flag. Optional. Display this help.\nArgument: binary - Callable. Required. Command to run.\nArgument: ... - Arguments. Optional. Any arguments are passed to `binary`.\nRun binary and output failed command upon error\nRequires: returnMessage helpArgument\n\n'
requires=$'returnMessage helpArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="140"
summary="Run binary and output failed command upon error"
summaryComputed="true"
usage="execute [ --help ] binary [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecute'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mbinary  '$'\e''[[(value)]mCallable. Required. Command to run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mArguments. Optional. Any arguments are passed to '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Run binary and output failed command upon error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: execute [ --help ] binary [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    binary  Callable. Required. Command to run.'$'\n''    ...     Arguments. Optional. Any arguments are passed to binary.'$'\n'''$'\n''Run binary and output failed command upon error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sugar-core.md"
