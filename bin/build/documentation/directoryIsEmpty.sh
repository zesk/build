#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="directory - Directory. Optional. Directory to check if empty."$'\n'""
base="directory.sh"
description="Does a directory exist and is it empty?"$'\n'""
file="bin/build/tools/directory.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Argument: directory - Directory. Optional. Directory to check if empty."$'\n'"Does a directory exist and is it empty?"$'\n'"Return Code: 2 - Directory does not exist"$'\n'"Return Code: 1 - Directory is not empty"$'\n'"Return Code: 0 - Directory is empty"$'\n'""$'\n'""
return_code="2 - Directory does not exist"$'\n'"1 - Directory is not empty"$'\n'"0 - Directory is empty"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="48944c2d998ec4950146d3ca4b1eba7cb335709c"
summary="Does a directory exist and is it empty?"
summaryComputed="true"
usage="directoryIsEmpty [ directory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryIsEmpty'$'\e''[0m '$'\e''[[(blue)]m[ directory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mdirectory  '$'\e''[[(value)]mDirectory. Optional. Directory to check if empty.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a directory exist and is it empty?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Directory does not exist'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Directory is not empty'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Directory is empty'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: directoryIsEmpty [[(blue)]m[ directory ]'$'\n'''$'\n''    [[(blue)]mdirectory  Directory. Optional. Directory to check if empty.'$'\n'''$'\n''Does a directory exist and is it empty?'$'\n'''$'\n''Return codes:'$'\n''- 2 - Directory does not exist'$'\n''- 1 - Directory is not empty'$'\n''- 0 - Directory is empty'$'\n'''
# elapsed 3.473
