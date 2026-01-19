#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-19
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="handler - Function. Required. Failure command"$'\n'"command ... - Callable. Required. Command to run."$'\n'""
base="_sugar.sh"
description="Run \`command\`, upon failure run \`handler\` with an environment error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="catchEnvironment"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Run \`command\`, upon failure run \`handler\` with an environment error"
usage="catchEnvironment handler command ..."
