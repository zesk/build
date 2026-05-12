#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
line="139"
rawComment=$'Argument: --help - Flag. Optional. Display this help.\nArgument: binary - Callable. Required. Command to run.\nArgument: ... - Arguments. Optional. Any arguments are passed to `binary`.\nRun binary and output failed command upon error\nRequires: returnMessage helpArgument\n\n'
requires=$'returnMessage helpArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="139"
summary="Run binary and output failed command upon error"
summaryComputed="true"
usage="execute [ --help ] binary [ ... ]"
