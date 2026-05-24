#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'code - UnsignedInteger. Required. Exit code to return\nhandler - Function. Required. Failure command, passed remaining arguments and error code.\ncommand ... - Callable. Required. Command to run.\n... - Arguments. Optional. Arguments to `command`\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run `command`, handle failure with `handler` with `code` and `command` as error\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchCode"
fnMarker="catchcode"
foundNames=([0]="argument" [1]="requires")
line="194"
rawComment=$'Run `command`, handle failure with `handler` with `code` and `command` as error\nArgument: code - UnsignedInteger. Required. Exit code to return\nArgument: handler - Function. Required. Failure command, passed remaining arguments and error code.\nArgument: command ... - Callable. Required. Command to run.\nArgument: ... - Arguments. Optional. Arguments to `command`\nRequires: isUnsignedInteger returnArgument isFunction isCallable\n\n'
requires=$'isUnsignedInteger returnArgument isFunction isCallable\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="194"
summary="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\`"
summaryComputed="true"
usage="catchCode code handler command ... [ ... ]"
