#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/utilities.sh"
argument="--mode mode - String. Optional."$'\n'"namedPipe"$'\n'"--writer line ... - When encountered all additional arguments are written to the runner."$'\n'"readerExecutable ... - Callable. Optional."$'\n'""
base="utilities.sh"
description="Single reader, multiple writers"$'\n'"Attempt at having docker communicate back to the outside world."$'\n'""
exitCode="0"
file="bin/build/tools/utilities.sh"
foundNames=([0]="argument")
rawComment="Single reader, multiple writers"$'\n'"Attempt at having docker communicate back to the outside world."$'\n'"Argument: --mode mode - String. Optional."$'\n'"Argument: namedPipe"$'\n'"Argument: --writer line ... - When encountered all additional arguments are written to the runner."$'\n'"Argument: readerExecutable ... - Callable. Optional."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/utilities.sh"
sourceModified="1769063211"
summary="Single reader, multiple writers"
usage="pipeRunner [ --mode mode ] [ namedPipe ] [ --writer line ... ] [ readerExecutable ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mpipeRunner'$'\e''[0m '$'\e''[[blue]m[ --mode mode ]'$'\e''[0m '$'\e''[[blue]m[ namedPipe ]'$'\e''[0m '$'\e''[[blue]m[ --writer line ... ]'$'\e''[0m '$'\e''[[blue]m[ readerExecutable ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--mode mode           '$'\e''[[value]mString. Optional.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mnamedPipe             '$'\e''[[value]mnamedPipe'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--writer line ...     '$'\e''[[value]mWhen encountered all additional arguments are written to the runner.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mreaderExecutable ...  '$'\e''[[value]mCallable. Optional.'$'\e''[[reset]m'$'\n'''$'\n''Single reader, multiple writers'$'\n''Attempt at having docker communicate back to the outside world.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pipeRunner [ --mode mode ] [ namedPipe ] [ --writer line ... ] [ readerExecutable ... ]'$'\n'''$'\n''    --mode mode           String. Optional.'$'\n''    namedPipe             namedPipe'$'\n''    --writer line ...     When encountered all additional arguments are written to the runner.'$'\n''    readerExecutable ...  Callable. Optional.'$'\n'''$'\n''Single reader, multiple writers'$'\n''Attempt at having docker communicate back to the outside world.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
