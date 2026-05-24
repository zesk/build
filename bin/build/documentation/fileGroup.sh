#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'file - File to get the owner for\n--help - Flag. Optional. Display this help.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the file group name\nOutputs the file group for each file passed on the command line\n\n'
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="fileGroup"
fnMarker="filegroup"
foundNames=([0]="argument" [1]="return_code")
line="523"
rawComment=$'Get the file group name\nArgument: file - File to get the owner for\nArgument: --help - Flag. Optional. Display this help.\nOutputs the file group for each file passed on the command line\nReturn Code: 0 - Success\nReturn Code: 1 - Unable to access file\n\n'
return_code=$'0 - Success\n1 - Unable to access file\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="523"
summary="Get the file group name"
summaryComputed="true"
usage="fileGroup [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileGroup'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile to get the owner for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the file group name'$'\n''Outputs the file group for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Unable to access file'
# shellcheck disable=SC2016
helpPlain='Usage: fileGroup [ file ] [ --help ]'$'\n'''$'\n''    file    File to get the owner for'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the file group name'$'\n''Outputs the file group for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Unable to access file'
documentationPath="documentation/source/tools/file.md"
