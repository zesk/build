#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"--skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"--show-skipped - Flag. Show skipped environment variables."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="dump.sh"
description="Output the environment shamelessly (not secure, not recommended)"$'\n'""
file="bin/build/tools/dump.sh"
rawComment="Output the environment shamelessly (not secure, not recommended)"$'\n'"Argument: --maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"Argument: --skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"Argument: --show-skipped - Flag. Show skipped environment variables."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceHash="6a45ba93dc346627d009bc14e9582d9ccda6e36e"
summary="Output the environment shamelessly (not secure, not recommended)"
summaryComputed="true"
usage="dumpEnvironmentUnsafe [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdumpEnvironmentUnsafe'$'\e''[0m '$'\e''[[(blue)]m[ --maximum-length maximumLength ]'$'\e''[0m '$'\e''[[(blue)]m[ --skip-env environmentVariable ]'$'\e''[0m '$'\e''[[(blue)]m[ --show-skipped ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--maximum-length maximumLength  '$'\e''[[(value)]mPositiveInteger. Optional. The maximum number of characters to output for each environment variable.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--skip-env environmentVariable  '$'\e''[[(value)]mEnvironmentVariable. Optional. Skip this environment variable (must match exactly).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--show-skipped                  '$'\e''[[(value)]mFlag. Show skipped environment variables.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the environment shamelessly (not secure, not recommended)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mdumpEnvironmentUnsafe [[(blue)]m[ --maximum-length maximumLength ] [[(blue)]m[ --skip-env environmentVariable ] [[(blue)]m[ --show-skipped ] [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--maximum-length maximumLength  [[(value)]mPositiveInteger. Optional. The maximum number of characters to output for each environment variable.[[(reset)]m'$'\n''    [[(blue)]m--skip-env environmentVariable  [[(value)]mEnvironmentVariable. Optional. Skip this environment variable (must match exactly).[[(reset)]m'$'\n''    [[(blue)]m--show-skipped                  [[(value)]mFlag. Show skipped environment variables.[[(reset)]m'$'\n''    [[(blue)]m--help                          [[(value)]mFlag. Optional. Display this help.[[(reset)]m'$'\n'''$'\n''Output the environment shamelessly (not secure, not recommended)'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''
# elapsed 4.793
