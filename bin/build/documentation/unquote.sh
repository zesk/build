#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="quote - String. Required. Must match beginning and end of string."$'\n'"value - String. Required. Value to unquote."$'\n'""
base="quote.sh"
description="Unquote a string"$'\n'""
file="bin/build/tools/quote.sh"
foundNames=([0]="argument")
rawComment="Unquote a string"$'\n'"Argument: quote - String. Required. Must match beginning and end of string."$'\n'"Argument: value - String. Required. Value to unquote."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceModified="1769063211"
summary="Unquote a string"
usage="unquote quote value"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]munquote'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mquote'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvalue'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mquote  '$'\e''[[(value)]mString. Required. Must match beginning and end of string.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mvalue  '$'\e''[[(value)]mString. Required. Value to unquote.'$'\e''[[(reset)]m'$'\n'''$'\n''Unquote a string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: unquote quote value'$'\n'''$'\n''    quote  String. Required. Must match beginning and end of string.'$'\n''    value  String. Required. Value to unquote.'$'\n'''$'\n''Unquote a string'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.623
