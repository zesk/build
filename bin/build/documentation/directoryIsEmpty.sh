#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - Directory. Optional. Directory to check if empty."$'\n'""
base="directory.sh"
description="Does a directory exist and is it empty?"$'\n'""
exitCode="0"
file="bin/build/tools/directory.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Argument: directory - Directory. Optional. Directory to check if empty."$'\n'"Does a directory exist and is it empty?"$'\n'"Return Code: 2 - Directory does not exist"$'\n'"Return Code: 1 - Directory is not empty"$'\n'"Return Code: 0 - Directory is empty"$'\n'""$'\n'""
return_code="2 - Directory does not exist"$'\n'"1 - Directory is not empty"$'\n'"0 - Directory is empty"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1769063211"
summary="Does a directory exist and is it empty?"
usage="directoryIsEmpty [ directory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdirectoryIsEmpty'$'\e''[0m '$'\e''[[blue]m[ directory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mdirectory  '$'\e''[[value]mDirectory. Optional. Directory to check if empty.'$'\e''[[reset]m'$'\n'''$'\n''Does a directory exist and is it empty?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Directory does not exist'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Directory is not empty'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Directory is empty'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryIsEmpty [ directory ]'$'\n'''$'\n''    directory  Directory. Optional. Directory to check if empty.'$'\n'''$'\n''Does a directory exist and is it empty?'$'\n'''$'\n''Return codes:'$'\n''- 2 - Directory does not exist'$'\n''- 1 - Directory is not empty'$'\n''- 0 - Directory is empty'$'\n'''
