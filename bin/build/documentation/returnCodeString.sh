#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'code ... - UnsignedInteger. String. Exit code value to output.\n--help - Flag. Optional. Display this help.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output the exit code as a string\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnCodeString"
fnMarker="returncodestring"
foundNames=([0]="argument" [1]="stdout" [2]="see")
line="60"
rawComment=$'Output the exit code as a string\nArgument: code ... - UnsignedInteger. String. Exit code value to output.\nArgument: --help - Flag. Optional. Display this help.\nstdout: exitCodeToken, one per line\nSee: returnCode\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'returnCode\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="60"
stdout=$'exitCodeToken, one per line\n'
summary="Output the exit code as a string"
summaryComputed="true"
usage="returnCodeString [ code ... ] [ --help ]"
