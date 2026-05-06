#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="contextStart - Directory. Required. Context in which the command should run."$'\n'"command - Callable. Required. Command to run in new context."$'\n'"... - Arguments. Optional. Arguments to the \`command\`."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run a command and ensure the build tools context matches the current project."$'\n'""$'\n'"Useful when you need to ensure the command is run with the correct version of Zesk Build."$'\n'""$'\n'"Avoid infinite loops here, call down."$'\n'""$'\n'""
descriptionLineCount="6"
example="    buildEnvironmentContext \"\$(pwd)\" environmentFileLoad \"\$(pwd)/.env\" --execute timing --slow 500 \"\$(pwd)/bin/ping.py\""$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentContext"
fnMarker="buildenvironmentcontext"
foundNames=([0]="argument" [1]="example")
line="686"
rawComment="Run a command and ensure the build tools context matches the current project."$'\n'"Useful when you need to ensure the command is run with the correct version of Zesk Build."$'\n'"Argument: contextStart - Directory. Required. Context in which the command should run."$'\n'"Argument: command - Callable. Required. Command to run in new context."$'\n'"Argument: ... - Arguments. Optional. Arguments to the \`command\`."$'\n'"Avoid infinite loops here, call down."$'\n'"Example:     buildEnvironmentContext \"\$(pwd)\" environmentFileLoad \"\$(pwd)/.env\" --execute timing --slow 500 \"\$(pwd)/bin/ping.py\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="8814c5b6b68b94aa734c4c337d9463150c6d754d"
sourceLine="686"
summary="Run a command and ensure the build tools context matches"
summaryComputed="true"
usage="buildEnvironmentContext contextStart command [ ... ]"
