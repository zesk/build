#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="string - EmptyString. Required. Path to binary to test if it is executable."$'\n'""
base="type.sh"
description="Test if all arguments are callable as a command"$'\n'"If no arguments are passed, returns exit code 1."$'\n'""
file="bin/build/tools/type.sh"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
rawComment="Test if all arguments are callable as a command"$'\n'"Argument: string - EmptyString. Required. Path to binary to test if it is executable."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are callable as a command"$'\n'"Return Code: 1 - One or or more arguments are callable as a command"$'\n'"Requires: throwArgument __help isExecutable isFunction"$'\n'""$'\n'""
requires="throwArgument __help isExecutable isFunction"$'\n'""
return_code="0 - All arguments are callable as a command"$'\n'"1 - One or or more arguments are callable as a command"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="5be1434c45364fe54b7ffac20b107397c81fc0c3"
summary="Test if all arguments are callable as a command"
usage="isCallable string"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misCallable'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstring'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstring  '$'\e''[[(value)]mEmptyString. Required. Path to binary to test if it is executable.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if all arguments are callable as a command'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All arguments are callable as a command'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or or more arguments are callable as a command'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isCallable string'$'\n'''$'\n''    string  EmptyString. Required. Path to binary to test if it is executable.'$'\n'''$'\n''Test if all arguments are callable as a command'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All arguments are callable as a command'$'\n''- 1 - One or or more arguments are callable as a command'$'\n'''
# elapsed 0.48
