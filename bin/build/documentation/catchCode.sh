#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="code - UnsignedInteger. Required. Exit code to return"$'\n'"handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"command ... - Callable. Required. Command to run."$'\n'"... - Arguments. Optional. Arguments to \`command\`"$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchCode"
fnMarker="catchcode"
foundNames=([0]="argument" [1]="requires")
line="194"
rawComment="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'"Argument: code - UnsignedInteger. Required. Exit code to return"$'\n'"Argument: handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'"Argument: ... - Arguments. Optional. Arguments to \`command\`"$'\n'"Requires: isUnsignedInteger returnArgument isFunction isCallable"$'\n'""$'\n'""
requires="isUnsignedInteger returnArgument isFunction isCallable"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="a07159f0d529eb650133ee48b457cb1ccff3f0d5"
sourceLine="194"
summary="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\`"
summaryComputed="true"
usage="catchCode code handler command ... [ ... ]"
