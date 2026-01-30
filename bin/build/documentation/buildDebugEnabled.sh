#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
BUILD_DEBUG=""
argument="moduleName - String. Optional. If \`BUILD_DEBUG\` contains any token passed, debugging is enabled."$'\n'""
base="debug.sh"
description="Is build debugging enabled?"$'\n'""
environment="BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. \`BUILD_DEBUG\` may be a comma-separated list of modules to target debugging."$'\n'""
example="    BUILD_DEBUG=false # All debugging disabled"$'\n'"    BUILD_DEBUG= # All debugging disabled"$'\n'"    unset BUILD_DEBUG # All debugging is disabled"$'\n'"    BUILD_DEBUG=true # All debugging is enabled"$'\n'"    BUILD_DEBUG=handler,bashPrompt # Debug \`handler\` and \`bashPrompt\` calls"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="argument" [1]="return_code" [2]="environment" [3]="example")
rawComment="Is build debugging enabled?"$'\n'"Argument: moduleName - String. Optional. If \`BUILD_DEBUG\` contains any token passed, debugging is enabled."$'\n'"Return Code: 1 - Debugging is not enabled (for any module)"$'\n'"Return Code: 0 - Debugging is enabled"$'\n'"Environment: BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. \`BUILD_DEBUG\` may be a comma-separated list of modules to target debugging."$'\n'"Example:     BUILD_DEBUG=false # All debugging disabled"$'\n'"Example:     BUILD_DEBUG= # All debugging disabled"$'\n'"Example:     unset BUILD_DEBUG # All debugging is disabled"$'\n'"Example:     BUILD_DEBUG=true # All debugging is enabled"$'\n'"Example:     BUILD_DEBUG=handler,bashPrompt # Debug \`handler\` and \`bashPrompt\` calls"$'\n'""$'\n'""
return_code="1 - Debugging is not enabled (for any module)"$'\n'"0 - Debugging is enabled"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="f288b9b3b91991d05bd6676a6b9ef73b9e0296b8"
summary="Is build debugging enabled?"
usage="buildDebugEnabled [ moduleName ]"
