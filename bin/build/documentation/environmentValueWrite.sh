#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="io.sh"
description="Write a value to a state file as NAME=\"value\""$'\n'"Argument: name - String. Required. Name to write."$'\n'"Argument: value - EmptyString. Optional. Value to write."$'\n'"Argument: ... - EmptyString. Optional. Additional values, when supplied, write this value as an array."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/environment/io.sh"
foundNames=()
rawComment="Write a value to a state file as NAME=\"value\""$'\n'"Argument: name - String. Required. Name to write."$'\n'"Argument: value - EmptyString. Optional. Value to write."$'\n'"Argument: ... - EmptyString. Optional. Additional values, when supplied, write this value as an array."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="ab40396c0bbaf04b90ac18495770691379efbd1a"
summary="Write a value to a state file as NAME=\"value\""
usage="environmentValueWrite"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueWrite'$'\e''[0m'$'\n'''$'\n''Write a value to a state file as NAME="value"'$'\n''Argument: name - String. Required. Name to write.'$'\n''Argument: value - EmptyString. Optional. Value to write.'$'\n''Argument: ... - EmptyString. Optional. Additional values, when supplied, write this value as an array.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueWrite'$'\n'''$'\n''Write a value to a state file as NAME="value"'$'\n''Argument: name - String. Required. Name to write.'$'\n''Argument: value - EmptyString. Optional. Value to write.'$'\n''Argument: ... - EmptyString. Optional. Additional values, when supplied, write this value as an array.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.451
