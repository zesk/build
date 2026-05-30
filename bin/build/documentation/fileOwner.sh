#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-27
# shellcheck disable=SC2034
argument=$'file - File to get the owner for\n--help - Flag. Optional. Display this help.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the file owner name\nOutputs the file owner for each file passed on the command line\n\n'
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="fileOwner"
fnMarker="fileowner"
foundNames=([0]="argument" [1]="return_code")
line="617"
rawComment=$'Get the file owner name\nArgument: file - File to get the owner for\nArgument: --help - Flag. Optional. Display this help.\nOutputs the file owner for each file passed on the command line\nReturn Code: 0 - Success\nReturn Code: 1 - Unable to access file\n\n'
return_code=$'0 - Success\n1 - Unable to access file\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="bbae84ac54a20b3ed2a0936cd425f12f62a59d01"
sourceLine="617"
summary="Get the file owner name"
summaryComputed="true"
usage="fileOwner [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileOwner'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile to get the owner for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the file owner name'$'\n''Outputs the file owner for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Unable to access file'
# shellcheck disable=SC2016
helpPlain='Usage: fileOwner [ file ] [ --help ]'$'\n'''$'\n''    file    File to get the owner for'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the file owner name'$'\n''Outputs the file owner for each file passed on the command line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Unable to access file'
documentationPath="documentation/source/tools/file.md"
