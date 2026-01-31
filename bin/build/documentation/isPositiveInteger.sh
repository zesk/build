#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="type.sh"
description="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'"Argument: value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'"Return Code: 0 - if it is a positive integer"$'\n'"Return Code: 1 - if it is not a positive integer"$'\n'"Requires: catchArgument isUnsignedInteger usageDocument"$'\n'""
file="bin/build/tools/type.sh"
foundNames=()
rawComment="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'"Argument: value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'"Return Code: 0 - if it is a positive integer"$'\n'"Return Code: 1 - if it is not a positive integer"$'\n'"Requires: catchArgument isUnsignedInteger usageDocument"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="5be1434c45364fe54b7ffac20b107397c81fc0c3"
summary="Test if an argument is a positive integer (non-zero)"
usage="isPositiveInteger"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misPositiveInteger'$'\e''[0m'$'\n'''$'\n''Test if an argument is a positive integer (non-zero)'$'\n''Takes one argument only.'$'\n''Argument: value - EmptyString. Required. Value to check if it is an unsigned integer'$'\n''Return Code: 0 - if it is a positive integer'$'\n''Return Code: 1 - if it is not a positive integer'$'\n''Requires: catchArgument isUnsignedInteger usageDocument'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isPositiveInteger'$'\n'''$'\n''Test if an argument is a positive integer (non-zero)'$'\n''Takes one argument only.'$'\n''Argument: value - EmptyString. Required. Value to check if it is an unsigned integer'$'\n''Return Code: 0 - if it is a positive integer'$'\n''Return Code: 1 - if it is not a positive integer'$'\n''Requires: catchArgument isUnsignedInteger usageDocument'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.463
