#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="string - String. Required. Path to binary to test if it is executable."$'\n'""
base="type.sh"
description="Test if all arguments are executable binaries"$'\n'"If no arguments are passed, returns exit code 1."$'\n'""
file="bin/build/tools/type.sh"
fn="isExecutable"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
rawComment="Test if all arguments are executable binaries"$'\n'"Argument: string - String. Required. Path to binary to test if it is executable."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are executable binaries"$'\n'"Return Code: 1 - One or or more arguments are not executable binaries"$'\n'"Requires: throwArgument  __help catchEnvironment command"$'\n'""$'\n'""
requires="throwArgument  __help catchEnvironment command"$'\n'""
return_code="0 - All arguments are executable binaries"$'\n'"1 - One or or more arguments are not executable binaries"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="c60b8f9d9123f5a6eb04a56b93a1ce09d79d8d26"
summary="Test if all arguments are executable binaries"
summaryComputed="true"
usage="isExecutable string"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misExecutable'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstring'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstring  '$'\e''[[(value)]mString. Required. Path to binary to test if it is executable.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if all arguments are executable binaries'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All arguments are executable binaries'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or or more arguments are not executable binaries'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isExecutable string'$'\n'''$'\n''    string  String. Required. Path to binary to test if it is executable.'$'\n'''$'\n''Test if all arguments are executable binaries'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All arguments are executable binaries'$'\n''- 1 - One or or more arguments are not executable binaries'$'\n'''
