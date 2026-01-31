#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="type.sh"
description="Test if all arguments are executable binaries"$'\n'"Argument: string ... - String. Required. Path to binary to test if it is executable."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are executable binaries"$'\n'"Return Code: 1 - One or or more arguments are not executable binaries"$'\n'"Requires: throwArgument  __help catchEnvironment command"$'\n'""
file="bin/build/tools/type.sh"
foundNames=()
rawComment="Test if all arguments are executable binaries"$'\n'"Argument: string ... - String. Required. Path to binary to test if it is executable."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are executable binaries"$'\n'"Return Code: 1 - One or or more arguments are not executable binaries"$'\n'"Requires: throwArgument  __help catchEnvironment command"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="5be1434c45364fe54b7ffac20b107397c81fc0c3"
summary="Test if all arguments are executable binaries"
usage="isExecutable"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misExecutable'$'\e''[0m'$'\n'''$'\n''Test if all arguments are executable binaries'$'\n''Argument: string ... - String. Required. Path to binary to test if it is executable.'$'\n''If no arguments are passed, returns exit code 1.'$'\n''Return Code: 0 - All arguments are executable binaries'$'\n''Return Code: 1 - One or or more arguments are not executable binaries'$'\n''Requires: throwArgument  __help catchEnvironment command'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isExecutable'$'\n'''$'\n''Test if all arguments are executable binaries'$'\n''Argument: string ... - String. Required. Path to binary to test if it is executable.'$'\n''If no arguments are passed, returns exit code 1.'$'\n''Return Code: 0 - All arguments are executable binaries'$'\n''Return Code: 1 - One or or more arguments are not executable binaries'$'\n''Requires: throwArgument  __help catchEnvironment command'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.483
