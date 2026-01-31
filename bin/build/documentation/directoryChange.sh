#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="directory.sh"
description="Argument: directory - Directory. Required. Directory to change to prior to running command."$'\n'"Argument: command - Callable. Required. Thing to do in this directory."$'\n'"Argument: ... - Arguments. Optional. Arguments to \`command\`."$'\n'"Run a command after changing directory to it and then returning to the previous directory afterwards."$'\n'"Requires: pushd popd"$'\n'""
file="bin/build/tools/directory.sh"
foundNames=()
rawComment="Argument: directory - Directory. Required. Directory to change to prior to running command."$'\n'"Argument: command - Callable. Required. Thing to do in this directory."$'\n'"Argument: ... - Arguments. Optional. Arguments to \`command\`."$'\n'"Run a command after changing directory to it and then returning to the previous directory afterwards."$'\n'"Requires: pushd popd"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="48944c2d998ec4950146d3ca4b1eba7cb335709c"
summary="Argument: directory - Directory. Required. Directory to change to prior"
usage="directoryChange"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryChange'$'\e''[0m'$'\n'''$'\n''Argument: directory - Directory. Required. Directory to change to prior to running command.'$'\n''Argument: command - Callable. Required. Thing to do in this directory.'$'\n''Argument: ... - Arguments. Optional. Arguments to '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m.'$'\n''Run a command after changing directory to it and then returning to the previous directory afterwards.'$'\n''Requires: pushd popd'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryChange'$'\n'''$'\n''Argument: directory - Directory. Required. Directory to change to prior to running command.'$'\n''Argument: command - Callable. Required. Thing to do in this directory.'$'\n''Argument: ... - Arguments. Optional. Arguments to command.'$'\n''Run a command after changing directory to it and then returning to the previous directory afterwards.'$'\n''Requires: pushd popd'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.444
