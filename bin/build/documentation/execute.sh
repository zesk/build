#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"binary - Callable. Required. Command to run."$'\n'"... - Arguments. Optional. Any arguments are passed to \`binary\`."$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run binary and output failed command upon error"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="execute"
fnMarker="execute"
foundNames=([0]="argument" [1]="requires")
line="140"
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: binary - Callable. Required. Command to run."$'\n'"Argument: ... - Arguments. Optional. Any arguments are passed to \`binary\`."$'\n'"Run binary and output failed command upon error"$'\n'"Requires: returnMessage helpArgument"$'\n'""$'\n'""
requires="returnMessage helpArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="859744e8330da27fd03e1da6874909739d06ce70"
sourceLine="140"
summary="Run binary and output failed command upon error"
summaryComputed="true"
usage="execute [ --help ] binary [ ... ]"
