#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="minimum - Integer|Empty. Minimum integer value to output."$'\n'"maximum - Integer|Empty. Maximum integer value to output."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Clamp digits between two integers"$'\n'"Reads stdin digits, one per line, and outputs only integer values between \$min and \$max"$'\n'""
file="bin/build/tools/colors.sh"
foundNames=([0]="argument")
rawComment="Clamp digits between two integers"$'\n'"Reads stdin digits, one per line, and outputs only integer values between \$min and \$max"$'\n'"Argument: minimum - Integer|Empty. Minimum integer value to output."$'\n'"Argument: maximum - Integer|Empty. Maximum integer value to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceHash="9f54e9ae3d6bd1960826e3412b3edfd9c241f895"
summary="Clamp digits between two integers"
usage="clampDigits [ minimum ] [ maximum ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mclampDigits'$'\e''[0m '$'\e''[[(blue)]m[ minimum ]'$'\e''[0m '$'\e''[[(blue)]m[ maximum ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mminimum  '$'\e''[[(value)]mInteger|Empty. Minimum integer value to output.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmaximum  '$'\e''[[(value)]mInteger|Empty. Maximum integer value to output.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Clamp digits between two integers'$'\n''Reads stdin digits, one per line, and outputs only integer values between $min and $max'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: clampDigits [ minimum ] [ maximum ] [ --help ]'$'\n'''$'\n''    minimum  Integer|Empty. Minimum integer value to output.'$'\n''    maximum  Integer|Empty. Maximum integer value to output.'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Clamp digits between two integers'$'\n''Reads stdin digits, one per line, and outputs only integer values between $min and $max'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.773
