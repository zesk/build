#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
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
sourceHash="3e4ac7234593313eddb63a76e2aa170841269b82"
summary="Is build debugging enabled?"
summaryComputed="true"
usage="buildDebugEnabled [ moduleName ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDebugEnabled'$'\e''[0m '$'\e''[[(blue)]m[ moduleName ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmoduleName  '$'\e''[[(value)]mString. Optional. If '$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m contains any token passed, debugging is enabled.'$'\e''[[(reset)]m'$'\n'''$'\n''Is build debugging enabled?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Debugging is not enabled (for any module)'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Debugging is enabled'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m - Set to non-blank to enable debugging, blank to disable. '$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m may be a comma-separated list of modules to target debugging.'$'\n'''$'\n''Example:'$'\n''    BUILD_DEBUG=false # All debugging disabled'$'\n''    BUILD_DEBUG= # All debugging disabled'$'\n''    unset BUILD_DEBUG # All debugging is disabled'$'\n''    BUILD_DEBUG=true # All debugging is enabled'$'\n''    BUILD_DEBUG=handler,bashPrompt # Debug '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m and '$'\e''[[(code)]mbashPrompt'$'\e''[[(reset)]m calls'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildDebugEnabled [ moduleName ]'$'\n'''$'\n''    moduleName  String. Optional. If BUILD_DEBUG contains any token passed, debugging is enabled.'$'\n'''$'\n''Is build debugging enabled?'$'\n'''$'\n''Return codes:'$'\n''- 1 - Debugging is not enabled (for any module)'$'\n''- 0 - Debugging is enabled'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. BUILD_DEBUG may be a comma-separated list of modules to target debugging.'$'\n'''$'\n''Example:'$'\n''    BUILD_DEBUG=false # All debugging disabled'$'\n''    BUILD_DEBUG= # All debugging disabled'$'\n''    unset BUILD_DEBUG # All debugging is disabled'$'\n''    BUILD_DEBUG=true # All debugging is enabled'$'\n''    BUILD_DEBUG=handler,bashPrompt # Debug handler and bashPrompt calls'$'\n'''
# elapsed 3.386
