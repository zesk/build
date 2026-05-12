#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument="none"
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs the maximum line length passed into stdin\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="fileLineMaximum"
fnMarker="filelinemaximum"
foundNames=([0]="stdin" [1]="stdout")
line="679"
rawComment=$'Outputs the maximum line length passed into stdin\nstdin: Lines are read from standard in and line length is computed for each line\nstdout: `UnsignedInteger`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="679"
stdin=$'Lines are read from standard in and line length is computed for each line\n'
stdout=$'`UnsignedInteger`\n'
summary="Outputs the maximum line length passed into stdin"
summaryComputed="true"
usage="fileLineMaximum"
