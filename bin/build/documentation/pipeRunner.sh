#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="utilities.sh"
description="Single reader, multiple writers"$'\n'"Attempt at having docker communicate back to the outside world."$'\n'"Argument: --mode mode - String. Optional."$'\n'"Argument: namedPipe"$'\n'"Argument: --writer line ... - When encountered all additional arguments are written to the runner."$'\n'"Argument: readerExecutable ... - Callable. Optional."$'\n'""
file="bin/build/tools/utilities.sh"
foundNames=()
rawComment="Single reader, multiple writers"$'\n'"Attempt at having docker communicate back to the outside world."$'\n'"Argument: --mode mode - String. Optional."$'\n'"Argument: namedPipe"$'\n'"Argument: --writer line ... - When encountered all additional arguments are written to the runner."$'\n'"Argument: readerExecutable ... - Callable. Optional."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/utilities.sh"
sourceHash="21f90476511667b340ae07460aa6c840727d047b"
summary="Single reader, multiple writers"
usage="pipeRunner"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpipeRunner'$'\e''[0m'$'\n'''$'\n''Single reader, multiple writers'$'\n''Attempt at having docker communicate back to the outside world.'$'\n''Argument: --mode mode - String. Optional.'$'\n''Argument: namedPipe'$'\n''Argument: --writer line ... - When encountered all additional arguments are written to the runner.'$'\n''Argument: readerExecutable ... - Callable. Optional.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pipeRunner'$'\n'''$'\n''Single reader, multiple writers'$'\n''Attempt at having docker communicate back to the outside world.'$'\n''Argument: --mode mode - String. Optional.'$'\n''Argument: namedPipe'$'\n''Argument: --writer line ... - When encountered all additional arguments are written to the runner.'$'\n''Argument: readerExecutable ... - Callable. Optional.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.742
