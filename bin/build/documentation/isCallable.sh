#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="type.sh"
description="Test if all arguments are callable as a command"$'\n'"Argument: string - EmptyString. Required. Path to binary to test if it is executable."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are callable as a command"$'\n'"Return Code: 1 - One or or more arguments are callable as a command"$'\n'"Requires: throwArgument __help isExecutable isFunction"$'\n'""
file="bin/build/tools/type.sh"
foundNames=()
rawComment="Test if all arguments are callable as a command"$'\n'"Argument: string - EmptyString. Required. Path to binary to test if it is executable."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are callable as a command"$'\n'"Return Code: 1 - One or or more arguments are callable as a command"$'\n'"Requires: throwArgument __help isExecutable isFunction"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="5be1434c45364fe54b7ffac20b107397c81fc0c3"
summary="Test if all arguments are callable as a command"
usage="isCallable"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misCallable'$'\e''[0m'$'\n'''$'\n''Test if all arguments are callable as a command'$'\n''Argument: string - EmptyString. Required. Path to binary to test if it is executable.'$'\n''If no arguments are passed, returns exit code 1.'$'\n''Return Code: 0 - All arguments are callable as a command'$'\n''Return Code: 1 - One or or more arguments are callable as a command'$'\n''Requires: throwArgument __help isExecutable isFunction'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isCallable'$'\n'''$'\n''Test if all arguments are callable as a command'$'\n''Argument: string - EmptyString. Required. Path to binary to test if it is executable.'$'\n''If no arguments are passed, returns exit code 1.'$'\n''Return Code: 0 - All arguments are callable as a command'$'\n''Return Code: 1 - One or or more arguments are callable as a command'$'\n''Requires: throwArgument __help isExecutable isFunction'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.475
