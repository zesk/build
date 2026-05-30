#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-27
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
line="705"
rawComment=$'Run a command and ensure the build tools context matches the current project.\nUseful when you need to ensure the command is run with the correct version of Zesk Build.\nArgument: startDirectory - Directory. Required. Context in which the command should run.\nArgument: command - Callable. Required. Command to run in new context.\nArgument: ... - Arguments. Optional. Arguments to the `command`.\nAvoid infinite loops here, call down.\nExample:     buildEnvironmentContext "$(pwd)" environmentFileLoad "$(pwd)/.env" --execute timing --slow 500 "$(pwd)/bin/ping.py"\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="16a877ce34323f71849bcba9805acd71769a633e"
sourceLine="705"
summary="Run a command and ensure the build tools context matches"
summaryComputed="true"
usage="buildEnvironmentContext startDirectory command [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentContext'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstartDirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstartDirectory  '$'\e''[[(value)]mDirectory. Required. Context in which the command should run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcommand         '$'\e''[[(value)]mCallable. Required. Command to run in new context.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...             '$'\e''[[(value)]mArguments. Optional. Arguments to the '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Run a command and ensure the build tools context matches the current project.'$'\n'''$'\n''Useful when you need to ensure the command is run with the correct version of Zesk Build.'$'\n'''$'\n''Avoid infinite loops here, call down.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    buildEnvironmentContext "$(pwd)" environmentFileLoad "$(pwd)/.env" --execute timing --slow 500 "$(pwd)/bin/ping.py"'
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentContext startDirectory command [ ... ]'$'\n'''$'\n''    startDirectory  Directory. Required. Context in which the command should run.'$'\n''    command         Callable. Required. Command to run in new context.'$'\n''    ...             Arguments. Optional. Arguments to the command.'$'\n'''$'\n''Run a command and ensure the build tools context matches the current project.'$'\n'''$'\n''Useful when you need to ensure the command is run with the correct version of Zesk Build.'$'\n'''$'\n''Avoid infinite loops here, call down.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    buildEnvironmentContext "$(pwd)" environmentFileLoad "$(pwd)/.env" --execute timing --slow 500 "$(pwd)/bin/ping.py"'
documentationPath="documentation/source/tools/build.md"
