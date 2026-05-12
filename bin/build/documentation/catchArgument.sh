#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'handler - String. Required. Failure command\ncommand ... - Callable. Required. Command to run.\n... - Arguments. Optional. Arguments to `command`\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run `command`, upon failure run `handler` with an argument error\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchArgument"
fnMarker="catchargument"
foundNames=([0]="argument" [1]="requires")
line="237"
rawComment=$'Run `command`, upon failure run `handler` with an argument error\nArgument: handler - String. Required. Failure command\nArgument: command ... - Callable. Required. Command to run.\nArgument: ... - Arguments. Optional. Arguments to `command`\nRequires: catchCode\n\n'
requires=$'catchCode\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="237"
summary="Run \`command\`, upon failure run \`handler\` with an argument error"
summaryComputed="true"
usage="catchArgument handler command ... [ ... ]"
