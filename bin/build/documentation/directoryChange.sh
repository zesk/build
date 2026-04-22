#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="directory - Directory. Required. Directory to change to prior to running command."$'\n'"command - Callable. Required. Thing to do in this directory."$'\n'"... - Arguments. Optional. Arguments to \`command\`."$'\n'""
base="directory.sh"
description="Run a command after changing directory to it and then returning to the previous directory afterwards."$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryChange"
foundNames=([0]="argument" [1]="requires")
line="32"
lowerFn="directorychange"
rawComment="Argument: directory - Directory. Required. Directory to change to prior to running command."$'\n'"Argument: command - Callable. Required. Thing to do in this directory."$'\n'"Argument: ... - Arguments. Optional. Arguments to \`command\`."$'\n'"Run a command after changing directory to it and then returning to the previous directory afterwards."$'\n'"Requires: pushd popd"$'\n'""$'\n'""
requires="pushd popd"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="da838a55948477df4605f58aff4c29b4f13319f7"
sourceLine="32"
summary="Run a command after changing directory to it and then"
summaryComputed="true"
usage="directoryChange directory command [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryChange'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. Directory to change to prior to running command.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcommand    '$'\e''[[(value)]mCallable. Required. Thing to do in this directory.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...        '$'\e''[[(value)]mArguments. Optional. Arguments to '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Run a command after changing directory to it and then returning to the previous directory afterwards.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryChange directory command [ ... ]'$'\n'''$'\n''    directory  Directory. Required. Directory to change to prior to running command.'$'\n''    command    Callable. Required. Thing to do in this directory.'$'\n''    ...        Arguments. Optional. Arguments to command.'$'\n'''$'\n''Run a command after changing directory to it and then returning to the previous directory afterwards.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/directory.md"
