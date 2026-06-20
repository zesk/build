#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'directory - Directory. Optional. Directory to check if empty.\n'
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Does a directory exist and is it empty?\n\n'
descriptionLineCount="2"
file="bin/build/tools/directory.sh"
fn="directoryIsEmpty"
fnMarker="directoryisempty"
foundNames=([0]="argument" [1]="return_code")
line="256"
original="directoryIsEmpty"
rawComment=$'Argument: directory - Directory. Optional. Directory to check if empty.\nDoes a directory exist and is it empty?\nReturn Code: 2 - Directory does not exist\nReturn Code: 1 - Directory is not empty\nReturn Code: 0 - Directory is empty\n\n'
return_code=$'2 - Directory does not exist\n1 - Directory is not empty\n0 - Directory is empty\n'
sourceFile="bin/build/tools/directory.sh"
sourceHash="56e2e47efbd4d48b0fa152ed5f06ec8d0ff20d9e"
sourceLine="256"
summary="Does a directory exist and is it empty?"
summaryComputed="true"
usage="directoryIsEmpty [ directory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryIsEmpty'$'\e''[0m '$'\e''[[(blue)]m[ directory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mdirectory  '$'\e''[[(value)]mDirectory. Optional. Directory to check if empty.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a directory exist and is it empty?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Directory does not exist'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Directory is not empty'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Directory is empty'
# shellcheck disable=SC2016
helpPlain='Usage: directoryIsEmpty [ directory ]'$'\n'''$'\n''    directory  Directory. Optional. Directory to check if empty.'$'\n'''$'\n''Does a directory exist and is it empty?'$'\n'''$'\n''Return codes:'$'\n''- 2 - Directory does not exist'$'\n''- 1 - Directory is not empty'$'\n''- 0 - Directory is empty'
documentationPath="documentation/source/tools/directory.md"
