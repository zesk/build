#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-22
# shellcheck disable=SC2034
argument="handler - String. Required. Failure command"$'\n'"command ... - Callable. Required. Command to run."$'\n'"... - Arguments. Optional. Arguments to \`command\`"$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`command\`, upon failure run \`handler\` with an environment error"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchEnvironment"
fnMarker="catchenvironment"
foundNames=([0]="argument" [1]="requires")
line="247"
rawComment="Run \`command\`, upon failure run \`handler\` with an environment error"$'\n'"Argument: handler - String. Required. Failure command"$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'"Argument: ... - Arguments. Optional. Arguments to \`command\`"$'\n'"Requires: catchCode"$'\n'""$'\n'""
requires="catchCode"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="859744e8330da27fd03e1da6874909739d06ce70"
sourceLine="247"
summary="Run \`command\`, upon failure run \`handler\` with an environment error"
summaryComputed="true"
usage="catchEnvironment handler command ... [ ... ]"
