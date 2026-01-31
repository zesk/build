#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="build.sh"
description="Run a command and ensure the build tools context matches the current project"$'\n'"Argument: contextStart - Directory. Required. Context in which the command should run."$'\n'"Argument: command ... - Required. Command to run in new context."$'\n'"Avoid infinite loops here, call down."$'\n'""
file="bin/build/tools/build.sh"
foundNames=()
rawComment="Run a command and ensure the build tools context matches the current project"$'\n'"Argument: contextStart - Directory. Required. Context in which the command should run."$'\n'"Argument: command ... - Required. Command to run in new context."$'\n'"Avoid infinite loops here, call down."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Run a command and ensure the build tools context matches"
usage="buildEnvironmentContext"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentContext'$'\e''[0m'$'\n'''$'\n''Run a command and ensure the build tools context matches the current project'$'\n''Argument: contextStart - Directory. Required. Context in which the command should run.'$'\n''Argument: command ... - Required. Command to run in new context.'$'\n''Avoid infinite loops here, call down.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentContext'$'\n'''$'\n''Run a command and ensure the build tools context matches the current project'$'\n''Argument: contextStart - Directory. Required. Context in which the command should run.'$'\n''Argument: command ... - Required. Command to run in new context.'$'\n''Avoid infinite loops here, call down.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.472
