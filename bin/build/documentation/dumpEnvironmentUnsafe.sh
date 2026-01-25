#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="--maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"--skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"--show-skipped - Flag. Show skipped environment variables."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="dump.sh"
description="Output the environment shamelessly (not secure, not recommended)"$'\n'""
exitCode="0"
file="bin/build/tools/dump.sh"
foundNames=([0]="argument")
rawComment="Output the environment shamelessly (not secure, not recommended)"$'\n'"Argument: --maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"Argument: --skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"Argument: --show-skipped - Flag. Show skipped environment variables."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceModified="1769184734"
summary="Output the environment shamelessly (not secure, not recommended)"
usage="dumpEnvironmentUnsafe [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdumpEnvironmentUnsafe'$'\e''[0m '$'\e''[[blue]m[ --maximum-length maximumLength ]'$'\e''[0m '$'\e''[[blue]m[ --skip-env environmentVariable ]'$'\e''[0m '$'\e''[[blue]m[ --show-skipped ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--maximum-length maximumLength  '$'\e''[[value]mPositiveInteger. Optional. The maximum number of characters to output for each environment variable.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--skip-env environmentVariable  '$'\e''[[value]mEnvironmentVariable. Optional. Skip this environment variable (must match exactly).'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--show-skipped                  '$'\e''[[value]mFlag. Show skipped environment variables.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help                          '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Output the environment shamelessly (not secure, not recommended)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dumpEnvironmentUnsafe [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --help ]'$'\n'''$'\n''    --maximum-length maximumLength  PositiveInteger. Optional. The maximum number of characters to output for each environment variable.'$'\n''    --skip-env environmentVariable  EnvironmentVariable. Optional. Skip this environment variable (must match exactly).'$'\n''    --show-skipped                  Flag. Show skipped environment variables.'$'\n''    --help                          Flag. Optional. Display this help.'$'\n'''$'\n''Output the environment shamelessly (not secure, not recommended)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
