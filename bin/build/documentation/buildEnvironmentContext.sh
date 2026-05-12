#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'startDirectory - Directory. Required. Context in which the command should run.\ncommand - Callable. Required. Command to run in new context.\n... - Arguments. Optional. Arguments to the `command`.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run a command and ensure the build tools context matches the current project.\n\nUseful when you need to ensure the command is run with the correct version of Zesk Build.\n\nAvoid infinite loops here, call down.\n\n'
descriptionLineCount="6"
example=$'    buildEnvironmentContext "$(pwd)" environmentFileLoad "$(pwd)/.env" --execute timing --slow 500 "$(pwd)/bin/ping.py"\n'
file="bin/build/tools/build.sh"
fn="buildEnvironmentContext"
fnMarker="buildenvironmentcontext"
foundNames=([0]="argument" [1]="example")
line="686"
rawComment=$'Run a command and ensure the build tools context matches the current project.\nUseful when you need to ensure the command is run with the correct version of Zesk Build.\nArgument: startDirectory - Directory. Required. Context in which the command should run.\nArgument: command - Callable. Required. Command to run in new context.\nArgument: ... - Arguments. Optional. Arguments to the `command`.\nAvoid infinite loops here, call down.\nExample:     buildEnvironmentContext "$(pwd)" environmentFileLoad "$(pwd)/.env" --execute timing --slow 500 "$(pwd)/bin/ping.py"\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="686"
summary="Run a command and ensure the build tools context matches"
summaryComputed="true"
usage="buildEnvironmentContext startDirectory command [ ... ]"
