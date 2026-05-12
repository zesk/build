#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="handler - String. Required. Failure command"$'\n'"command ... - Callable. Required. Command to run."$'\n'"... - Arguments. Optional. Arguments to \`command\`"$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`command\`, upon failure run \`handler\` with an argument error"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchArgument"
fnMarker="catchargument"
foundNames=([0]="argument" [1]="requires")
line="238"
rawComment="Run \`command\`, upon failure run \`handler\` with an argument error"$'\n'"Argument: handler - String. Required. Failure command"$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'"Argument: ... - Arguments. Optional. Arguments to \`command\`"$'\n'"Requires: catchCode"$'\n'""$'\n'""
requires="catchCode"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="f483140af62e442b07342b869da4ea17b676a4e1"
sourceLine="238"
summary="Run \`command\`, upon failure run \`handler\` with an argument error"
summaryComputed="true"
usage="catchArgument handler command ... [ ... ]"
