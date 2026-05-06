#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--mode mode - String. Optional."$'\n'"namedPipe"$'\n'"--writer line ... - When encountered all additional arguments are written to the runner."$'\n'"readerExecutable ... - Callable. Optional."$'\n'""
base="utilities.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Single reader, multiple writers"$'\n'"Attempt at having docker communicate back to the outside world."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/utilities.sh"
fn="pipeRunner"
fnMarker="piperunner"
foundNames=([0]="argument")
line="185"
rawComment="Single reader, multiple writers"$'\n'"Attempt at having docker communicate back to the outside world."$'\n'"Argument: --mode mode - String. Optional."$'\n'"Argument: namedPipe"$'\n'"Argument: --writer line ... - When encountered all additional arguments are written to the runner."$'\n'"Argument: readerExecutable ... - Callable. Optional."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/utilities.sh"
sourceHash="94563d0a08741ddbc0e4c700e450e33a3cb9e86f"
sourceLine="185"
summary="Single reader, multiple writers"
summaryComputed="true"
usage="pipeRunner [ --mode mode ] [ namedPipe ] [ --writer line ... ] [ readerExecutable ... ]"
