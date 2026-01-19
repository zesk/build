#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="handler - Function. Required. Failure command"$'\n'"quietLog - File. Required. File to output log to temporarily for this command. If \`quietLog\` is \`-\` then creates a temporary file for the command which is deleted automatically."$'\n'"command ... - Callable. Required. Thing to run and append output to \`quietLog\`."$'\n'""
base="sugar.sh"
description="Run \`handler\` with an environment error"$'\n'""
file="bin/build/tools/sugar.sh"
fn="catchEnvironmentQuiet"
foundNames=([0]="argument" [1]="requires")
requires="isFunction returnArgument buildFailed debuggingStack throwEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/sugar.sh"
sourceModified="1768769473"
summary="Run \`handler\` with an environment error"
usage="catchEnvironmentQuiet handler quietLog command ..."
