#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/utilities.sh"
argument="--mode mode - String. Optional."$'\n'"namedPipe"$'\n'"--writer line ... - When encountered all additional arguments are written to the runner."$'\n'"readerExecutable ... - Callable. Optional."$'\n'""
base="utilities.sh"
description="Single reader, multiple writers"$'\n'"Attempt at having docker communicate back to the outside world."$'\n'""
file="bin/build/tools/utilities.sh"
fn="pipeRunner"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/utilities.sh"
sourceModified="1768756695"
summary="Single reader, multiple writers"
usage="pipeRunner [ --mode mode ] [ namedPipe ] [ --writer line ... ] [ readerExecutable ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpipeRunner[0m [94m[ --mode mode ][0m [94m[ namedPipe ][0m [94m[ --writer line ... ][0m [94m[ readerExecutable ... ][0m

    [94m--mode mode           [1;97mString. Optional.[0m
    [94mnamedPipe             [1;97mnamedPipe[0m
    [94m--writer line ...     [1;97mWhen encountered all additional arguments are written to the runner.[0m
    [94mreaderExecutable ...  [1;97mCallable. Optional.[0m

Single reader, multiple writers
Attempt at having docker communicate back to the outside world.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: pipeRunner [ --mode mode ] [ namedPipe ] [ --writer line ... ] [ readerExecutable ... ]

    --mode mode           String. Optional.
    namedPipe             namedPipe
    --writer line ...     When encountered all additional arguments are written to the runner.
    readerExecutable ...  Callable. Optional.

Single reader, multiple writers
Attempt at having docker communicate back to the outside world.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
