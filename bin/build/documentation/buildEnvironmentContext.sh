#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="contextStart - Directory. Required. Context in which the command should run."$'\n'"command - Callable. Required. Command to run in new context."$'\n'"... - Arguments. Optional. Arguments to the \`command\`."$'\n'""
base="build.sh"
description="Run a command and ensure the build tools context matches the current project"$'\n'"Avoid infinite loops here, call down."$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentContext"
foundNames=([0]="argument")
line="676"
lowerFn="buildenvironmentcontext"
rawComment="Run a command and ensure the build tools context matches the current project"$'\n'"Argument: contextStart - Directory. Required. Context in which the command should run."$'\n'"Argument: command - Callable. Required. Command to run in new context."$'\n'"Argument: ... - Arguments. Optional. Arguments to the \`command\`."$'\n'"Avoid infinite loops here, call down."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="01d4aa56fc82af7cb49474878512de1aabd62c60"
sourceLine="676"
summary="Run a command and ensure the build tools context matches"
summaryComputed="true"
usage="buildEnvironmentContext contextStart command [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentContext'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcontextStart'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcontextStart  '$'\e''[[(value)]mDirectory. Required. Context in which the command should run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcommand       '$'\e''[[(value)]mCallable. Required. Command to run in new context.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...           '$'\e''[[(value)]mArguments. Optional. Arguments to the '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Run a command and ensure the build tools context matches the current project'$'\n''Avoid infinite loops here, call down.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentContext contextStart command [ ... ]'$'\n'''$'\n''    contextStart  Directory. Required. Context in which the command should run.'$'\n''    command       Callable. Required. Command to run in new context.'$'\n''    ...           Arguments. Optional. Arguments to the command.'$'\n'''$'\n''Run a command and ensure the build tools context matches the current project'$'\n''Avoid infinite loops here, call down.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/build.md"
