#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="code - UnsignedInteger. Required. Exit code to return"$'\n'"handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"command ... - Callable. Required. Command to run."$'\n'""
base="_sugar.sh"
description="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="catchCode"
foundNames=([0]="argument" [1]="requires")
requires="isUnsignedInteger returnArgument isFunction isCallable"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/_sugar.sh"
sourceModified="1768695727"
summary="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\`"
usage="catchCode code handler command ..."
