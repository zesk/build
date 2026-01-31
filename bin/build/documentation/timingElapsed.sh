#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="timing.sh"
description="Summary: Show elapsed time from a start time"$'\n'"Argument: timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     init=\$(timingStart)"$'\n'"Example:     ..."$'\n'"Example:     timingElapsed \"\$init\""$'\n'"Requires: __timestamp returnEnvironment validate date"$'\n'""
file="bin/build/tools/timing.sh"
foundNames=()
rawComment="Summary: Show elapsed time from a start time"$'\n'"Argument: timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     init=\$(timingStart)"$'\n'"Example:     ..."$'\n'"Example:     timingElapsed \"\$init\""$'\n'"Requires: __timestamp returnEnvironment validate date"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="8cfb9a50fadfff4b381ff34068eab3136b206319"
summary="Summary: Show elapsed time from a start time"
usage="timingElapsed"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingElapsed'$'\e''[0m'$'\n'''$'\n''Summary: Show elapsed time from a start time'$'\n''Argument: timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     init=$(timingStart)'$'\n''Example:     ...'$'\n''Example:     timingElapsed "$init"'$'\n''Requires: __timestamp returnEnvironment validate date'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timingElapsed'$'\n'''$'\n''Summary: Show elapsed time from a start time'$'\n''Argument: timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     init=$(timingStart)'$'\n''Example:     ...'$'\n''Example:     timingElapsed "$init"'$'\n''Requires: __timestamp returnEnvironment validate date'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.484
