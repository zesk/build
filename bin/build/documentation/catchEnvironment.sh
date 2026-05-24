#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'handler - String. Required. Failure command\ncommand ... - Callable. Required. Command to run.\n... - Arguments. Optional. Arguments to `command`\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run `command`, upon failure run `handler` with an environment error\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchEnvironment"
fnMarker="catchenvironment"
foundNames=([0]="argument" [1]="requires")
line="247"
rawComment=$'Run `command`, upon failure run `handler` with an environment error\nArgument: handler - String. Required. Failure command\nArgument: command ... - Callable. Required. Command to run.\nArgument: ... - Arguments. Optional. Arguments to `command`\nRequires: catchCode\n\n'
requires=$'catchCode\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="247"
summary="Run \`command\`, upon failure run \`handler\` with an environment error"
summaryComputed="true"
usage="catchEnvironment handler command ... [ ... ]"
