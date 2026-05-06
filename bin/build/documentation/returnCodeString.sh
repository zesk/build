#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="code ... - UnsignedInteger. String. Exit code value to output."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output the exit code as a string"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnCodeString"
fnMarker="returncodestring"
foundNames=([0]="argument" [1]="stdout" [2]="see")
line="60"
rawComment="Output the exit code as a string"$'\n'"Argument: code ... - UnsignedInteger. String. Exit code value to output."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: exitCodeToken, one per line"$'\n'"See: returnCode"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="returnCode"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="a07159f0d529eb650133ee48b457cb1ccff3f0d5"
sourceLine="60"
stdout="exitCodeToken, one per line"$'\n'""
summary="Output the exit code as a string"
summaryComputed="true"
usage="returnCodeString [ code ... ] [ --help ]"
