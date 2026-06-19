#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
BUILD_DEBUG="fingerprint-audit,handler"
argument=$'moduleName - String. Optional. If `BUILD_DEBUG` contains any token passed, debugging is enabled.\n'
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is build debugging enabled?\n\n'
descriptionLineCount="2"
environment=$'BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. `BUILD_DEBUG` may be a comma-separated list of modules to target debugging.\n'
example=$'    BUILD_DEBUG=false # All debugging disabled\n    BUILD_DEBUG= # All debugging disabled\n    unset BUILD_DEBUG # All debugging is disabled\n    BUILD_DEBUG=true # All debugging is enabled\n    BUILD_DEBUG=handler,bashPrompt # Debug `handler` and `bashPrompt` calls\n    if buildDebugEnabled bashPrompt; then\n        # ... prompt debugging code\n    fi\n'
file="bin/build/tools/debug.sh"
fn="buildDebugEnabled"
fnMarker="builddebugenabled"
foundNames=([0]="argument" [1]="return_code" [2]="environment" [3]="example")
line="24"
rawComment=$'Is build debugging enabled?\nArgument: moduleName - String. Optional. If `BUILD_DEBUG` contains any token passed, debugging is enabled.\nReturn Code: 1 - Debugging is not enabled (for any module)\nReturn Code: 0 - Debugging is enabled\nEnvironment: BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. `BUILD_DEBUG` may be a comma-separated list of modules to target debugging.\nExample:     BUILD_DEBUG=false # All debugging disabled\nExample:     BUILD_DEBUG= # All debugging disabled\nExample:     unset BUILD_DEBUG # All debugging is disabled\nExample:     BUILD_DEBUG=true # All debugging is enabled\nExample:     BUILD_DEBUG=handler,bashPrompt # Debug `handler` and `bashPrompt` calls\nExample:     if buildDebugEnabled bashPrompt; then\nExample:         # ... prompt debugging code\nExample:     fi\n\n'
return_code=$'1 - Debugging is not enabled (for any module)\n0 - Debugging is enabled\n'
sourceFile="bin/build/tools/debug.sh"
sourceHash="c698b75c5757732f1b8a82693f110a2be335611f"
sourceLine="24"
summary="Is build debugging enabled?"
summaryComputed="true"
usage="buildDebugEnabled [ moduleName ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDebugEnabled'$'\e''[0m '$'\e''[[(blue)]m[ moduleName ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmoduleName  '$'\e''[[(value)]mString. Optional. If '$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m contains any token passed, debugging is enabled.'$'\e''[[(reset)]m'$'\n'''$'\n''Is build debugging enabled?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Debugging is not enabled (for any module)'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Debugging is enabled'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m - Set to non-blank to enable debugging, blank to disable. '$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m may be a comma-separated list of modules to target debugging.'$'\n'''$'\n''Example:'$'\n''    BUILD_DEBUG=false # All debugging disabled'$'\n''    BUILD_DEBUG= # All debugging disabled'$'\n''    unset BUILD_DEBUG # All debugging is disabled'$'\n''    BUILD_DEBUG=true # All debugging is enabled'$'\n''    BUILD_DEBUG=handler,bashPrompt # Debug '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m and '$'\e''[[(code)]mbashPrompt'$'\e''[[(reset)]m calls'$'\n''    if buildDebugEnabled bashPrompt; then'$'\n''        # ... prompt debugging code'$'\n''    fi'
# shellcheck disable=SC2016
helpPlain='Usage: buildDebugEnabled [ moduleName ]'$'\n'''$'\n''    moduleName  String. Optional. If BUILD_DEBUG contains any token passed, debugging is enabled.'$'\n'''$'\n''Is build debugging enabled?'$'\n'''$'\n''Return codes:'$'\n''- 1 - Debugging is not enabled (for any module)'$'\n''- 0 - Debugging is enabled'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. BUILD_DEBUG may be a comma-separated list of modules to target debugging.'$'\n'''$'\n''Example:'$'\n''    BUILD_DEBUG=false # All debugging disabled'$'\n''    BUILD_DEBUG= # All debugging disabled'$'\n''    unset BUILD_DEBUG # All debugging is disabled'$'\n''    BUILD_DEBUG=true # All debugging is enabled'$'\n''    BUILD_DEBUG=handler,bashPrompt # Debug handler and bashPrompt calls'$'\n''    if buildDebugEnabled bashPrompt; then'$'\n''        # ... prompt debugging code'$'\n''    fi'
documentationPath="documentation/source/tools/debug.md"
