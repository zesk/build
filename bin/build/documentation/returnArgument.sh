#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="message ... - String. Optional. Message to output."$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnArgument"
fnMarker="returnargument"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="257"
rawComment="Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`."$'\n'"Argument: message ... - String. Optional. Message to output."$'\n'"Return Code: 2"$'\n'"Requires: returnMessage"$'\n'""$'\n'""
requires="returnMessage"$'\n'""
return_code="2"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="f483140af62e442b07342b869da4ea17b676a4e1"
sourceLine="257"
summary="Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`."
summaryComputed="true"
usage="returnArgument [ message ... ]"
