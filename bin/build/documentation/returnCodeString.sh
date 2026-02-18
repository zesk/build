#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-18
# shellcheck disable=SC2034
argument="code ... - UnsignedInteger. String. Exit code value to output."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="_sugar.sh"
description="Output the exit code as a string"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnCodeString"
foundNames=([0]="argument" [1]="stdout")
rawComment="Output the exit code as a string"$'\n'"Argument: code ... - UnsignedInteger. String. Exit code value to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: exitCodeToken, one per line"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="00f5bf2862b4fee06819afcf6d6db6adc911bcff"
stdout="exitCodeToken, one per line"$'\n'""
summary="Output the exit code as a string"
summaryComputed="true"
usage="returnCodeString [ code ... ] [ --help ]"
