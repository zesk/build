#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="python.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install `python`\n\nWhen this tool succeeds the `python` binary is available in the local operating system.\n\n'
descriptionLineCount="4"
file="bin/build/tools/python.sh"
fn="pythonInstall"
fnMarker="pythoninstall"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="19"
rawComment=$'Install `python`\nSummary: Install `python`\nWhen this tool succeeds the `python` binary is available in the local operating system.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 1 - If installation fails\nReturn Code: 0 - If installation succeeds\n\n'
return_code=$'1 - If installation fails\n0 - If installation succeeds\n'
sourceFile="bin/build/tools/python.sh"
sourceHash="41488c39a086a773d0c97f580808181e9997f5f8"
sourceLine="19"
summary="Install \`python\`"
summaryComputed=""
usage="pythonInstall [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpythonInstall'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Install '$'\e''[[(code)]mpython'$'\e''[[(reset)]m'$'\n'''$'\n''When this tool succeeds the '$'\e''[[(code)]mpython'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If installation succeeds'
# shellcheck disable=SC2016
helpPlain='Usage: pythonInstall [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Install python'$'\n'''$'\n''When this tool succeeds the python binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation fails'$'\n''- 0 - If installation succeeds'
documentationPath="documentation/source/tools/install.md"
