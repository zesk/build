#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="name - String. Required. Name to write."$'\n'"value - EmptyString. Optional. Value to write."$'\n'"... - EmptyString. Optional. Additional values, when supplied, write this value as an array."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
description="Write a value to a state file as NAME=\"value\""$'\n'""
file="bin/build/tools/environment/io.sh"
foundNames=([0]="argument")
rawComment="Write a value to a state file as NAME=\"value\""$'\n'"Argument: name - String. Required. Name to write."$'\n'"Argument: value - EmptyString. Optional. Value to write."$'\n'"Argument: ... - EmptyString. Optional. Additional values, when supplied, write this value as an array."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="3af1fd933e859692ce77e0ffdcfdcef6ad09e283"
summary="Write a value to a state file as NAME=\"value\""
usage="environmentValueWrite name [ value ] [ ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueWrite'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mname    '$'\e''[[(value)]mString. Required. Name to write.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue   '$'\e''[[(value)]mEmptyString. Optional. Value to write.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mEmptyString. Optional. Additional values, when supplied, write this value as an array.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Write a value to a state file as NAME="value"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueWrite name [[(blue)]m[ value ] [[(blue)]m[ ... ] [[(blue)]m[ --help ]'$'\n'''$'\n''    name    String. Required. Name to write.'$'\n''    [[(blue)]mvalue   EmptyString. Optional. Value to write.'$'\n''    [[(blue)]m...     EmptyString. Optional. Additional values, when supplied, write this value as an array.'$'\n''    [[(blue)]m--help  Flag. Optional. Display this help.'$'\n'''$'\n''Write a value to a state file as NAME="value"'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
# elapsed 2.59
