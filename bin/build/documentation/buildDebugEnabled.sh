#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="moduleName - String. Optional. If \`BUILD_DEBUG\` contains any token passed, debugging is enabled."$'\n'""
base="debug.sh"
description="Is build debugging enabled?"$'\n'""$'\n'"Return Code: 1 - Debugging is not enabled (for any module)"$'\n'"Return Code: 0 - Debugging is enabled"$'\n'""
environment="BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. \`BUILD_DEBUG\` may be a comma-separated list of modules to target debugging."$'\n'""
example="    BUILD_DEBUG=false # All debugging disabled"$'\n'"    BUILD_DEBUG= # All debugging disabled"$'\n'"    unset BUILD_DEBUG # All debugging is disabled"$'\n'"    BUILD_DEBUG=true # All debugging is enabled"$'\n'"    BUILD_DEBUG=handler,bashPrompt # Debug \`handler\` and \`bashPrompt\` calls"$'\n'""
file="bin/build/tools/debug.sh"
fn="buildDebugEnabled"
foundNames=([0]="argument" [1]="environment" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/debug.sh"
sourceModified="1768759254"
summary="Is build debugging enabled?"
usage="buildDebugEnabled [ moduleName ]"
