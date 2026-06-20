#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'string - String. Required. Path to binary to test if it is executable.\n'
base="type.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Test if all arguments are executable binaries\nIf no arguments are passed, returns exit code 1.\n\n'
descriptionLineCount="3"
environment=$'PATH\n'
file="bin/build/tools/type.sh"
fn="isExecutable"
fnMarker="isexecutable"
foundNames=([0]="argument" [1]="return_code" [2]="requires" [3]="environment")
line="219"
original="isExecutable"
rawComment=$'Test if all arguments are executable binaries\nArgument: string - String. Required. Path to binary to test if it is executable.\nIf no arguments are passed, returns exit code 1.\nReturn Code: 0 - All arguments are executable binaries\nReturn Code: 1 - One or or more arguments are not executable binaries\nRequires: throwArgument  helpArgument type\nEnvironment: PATH\n\n'
requires=$'throwArgument  helpArgument type\n'
return_code=$'0 - All arguments are executable binaries\n1 - One or or more arguments are not executable binaries\n'
sourceFile="bin/build/tools/type.sh"
sourceHash="3df0d84917e775e2aba0d9280d56eb8d73b4a8c3"
sourceLine="219"
summary="Test if all arguments are executable binaries"
summaryComputed="true"
usage="isExecutable string"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misExecutable'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstring'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstring  '$'\e''[[(value)]mString. Required. Path to binary to test if it is executable.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if all arguments are executable binaries'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All arguments are executable binaries'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or or more arguments are not executable binaries'$'\n'''$'\n''Environment variables:'$'\n''- PATH'
# shellcheck disable=SC2016
helpPlain='Usage: isExecutable string'$'\n'''$'\n''    string  String. Required. Path to binary to test if it is executable.'$'\n'''$'\n''Test if all arguments are executable binaries'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All arguments are executable binaries'$'\n''- 1 - One or or more arguments are not executable binaries'$'\n'''$'\n''Environment variables:'$'\n''- PATH'
documentationPath="documentation/source/tools/type.md"
