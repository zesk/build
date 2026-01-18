#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/utilities.sh"
argument="--mode mode - String. Optional."$'\n'"namedPipe"$'\n'"--writer line ... - When encountered all additional arguments are written to the runner."$'\n'"readerExecutable ... - Callable. Optional."$'\n'""
base="utilities.sh"
description="Single reader, multiple writers"$'\n'"Attempt at having docker communicate back to the outside world."$'\n'""
file="bin/build/tools/utilities.sh"
fn="pipeRunner"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/utilities.sh"
sourceModified="1768756695"
summary="Single reader, multiple writers"
usage="pipeRunner [ --mode mode ] [ namedPipe ] [ --writer line ... ] [ readerExecutable ... ]"
