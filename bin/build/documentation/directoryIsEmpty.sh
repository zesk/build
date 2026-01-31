#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="directory.sh"
description="Argument: directory - Directory. Optional. Directory to check if empty."$'\n'"Does a directory exist and is it empty?"$'\n'"Return Code: 2 - Directory does not exist"$'\n'"Return Code: 1 - Directory is not empty"$'\n'"Return Code: 0 - Directory is empty"$'\n'""
file="bin/build/tools/directory.sh"
foundNames=()
rawComment="Argument: directory - Directory. Optional. Directory to check if empty."$'\n'"Does a directory exist and is it empty?"$'\n'"Return Code: 2 - Directory does not exist"$'\n'"Return Code: 1 - Directory is not empty"$'\n'"Return Code: 0 - Directory is empty"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="48944c2d998ec4950146d3ca4b1eba7cb335709c"
summary="Argument: directory - Directory. Optional. Directory to check if empty."
usage="directoryIsEmpty"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryIsEmpty'$'\e''[0m'$'\n'''$'\n''Argument: directory - Directory. Optional. Directory to check if empty.'$'\n''Does a directory exist and is it empty?'$'\n''Return Code: 2 - Directory does not exist'$'\n''Return Code: 1 - Directory is not empty'$'\n''Return Code: 0 - Directory is empty'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryIsEmpty'$'\n'''$'\n''Argument: directory - Directory. Optional. Directory to check if empty.'$'\n''Does a directory exist and is it empty?'$'\n''Return Code: 2 - Directory does not exist'$'\n''Return Code: 1 - Directory is not empty'$'\n''Return Code: 0 - Directory is empty'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.516
