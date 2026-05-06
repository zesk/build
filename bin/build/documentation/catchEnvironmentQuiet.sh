#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="handler - Function. Required. Failure command"$'\n'"quietLog - File. Required. File to output log to temporarily for this command. If \`quietLog\` is \`-\` then creates a temporary file for the command which is deleted automatically."$'\n'"command ... - Callable. Required. Thing to run and append output to \`quietLog\`."$'\n'""
base="sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`handler\` with an environment error"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/sugar.sh"
fn="catchEnvironmentQuiet"
fnMarker="catchenvironmentquiet"
foundNames=([0]="argument" [1]="requires")
line="16"
rawComment="Run \`handler\` with an environment error"$'\n'"Argument: handler - Function. Required. Failure command"$'\n'"Argument: quietLog - File. Required. File to output log to temporarily for this command. If \`quietLog\` is \`-\` then creates a temporary file for the command which is deleted automatically."$'\n'"Argument: command ... - Callable. Required. Thing to run and append output to \`quietLog\`."$'\n'"Requires: isFunction returnArgument debuggingStack throwEnvironment"$'\n'""$'\n'""
requires="isFunction returnArgument debuggingStack throwEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="e8338cd30cac46f1f4725c84ca79d511b7921f72"
sourceLine="16"
summary="Run \`handler\` with an environment error"
summaryComputed="true"
usage="catchEnvironmentQuiet handler quietLog command ..."
