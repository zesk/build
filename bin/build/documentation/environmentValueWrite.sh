#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'name - String. Required. Name to write.\nvalue - EmptyString. Optional. Value to write.\n... - EmptyString. Optional. Additional values, when supplied, write this value as an array.\n--help - Flag. Optional. Display this help.\n'
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Write a value to a state file as NAME="value"\n\n'
descriptionLineCount="2"
file="bin/build/tools/environment/io.sh"
fn="environmentValueWrite"
fnMarker="environmentvaluewrite"
foundNames=([0]="argument")
line="13"
rawComment=$'Write a value to a state file as NAME="value"\nArgument: name - String. Required. Name to write.\nArgument: value - EmptyString. Optional. Value to write.\nArgument: ... - EmptyString. Optional. Additional values, when supplied, write this value as an array.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="9d970c9247c918e4438d4046d4dcca32d13b665b"
sourceLine="13"
summary="Write a value to a state file as NAME=\"value\""
summaryComputed="true"
usage="environmentValueWrite name [ value ] [ ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentValueWrite'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mname'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mname    '$'\e''[[(value)]mString. Required. Name to write.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue   '$'\e''[[(value)]mEmptyString. Optional. Value to write.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mEmptyString. Optional. Additional values, when supplied, write this value as an array.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Write a value to a state file as NAME="value"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueWrite name [ value ] [ ... ] [ --help ]'$'\n'''$'\n''    name    String. Required. Name to write.'$'\n''    value   EmptyString. Optional. Value to write.'$'\n''    ...     EmptyString. Optional. Additional values, when supplied, write this value as an array.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Write a value to a state file as NAME="value"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/environment.md"
