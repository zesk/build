#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-08
# shellcheck disable=SC2034
argument="file - File to get the owner for"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Get the file group name"$'\n'"Outputs the file group for each file passed on the command line"$'\n'""
file="bin/build/tools/file.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Get the file group name"$'\n'"Argument: file - File to get the owner for"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs the file group for each file passed on the command line"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Unable to access file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Unable to access file"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="ddb116448fdcba656336f2f25e7f2ec6eb97eaff"
summary="Get the file group name"
summaryComputed="true"
usage="fileGroup [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileGroup'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile to get the owner for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the file group name'$'\n''Outputs the file group for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Unable to access file'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileGroup [ file ] [ --help ]'$'\n'''$'\n''    file    File to get the owner for'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the file group name'$'\n''Outputs the file group for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Unable to access file'$'\n'''
