#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Trim whitespace from beginning and end of a stream\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="textTrimBoth"
fnMarker="texttrimboth"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="235"
rawComment=$'Trim whitespace from beginning and end of a stream\nArgument: --help - Flag. Optional. Display this help.\nstdin: Reads lines from stdin until EOF\nstdout: Outputs modified lines\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="235"
stdin=$'Reads lines from stdin until EOF\n'
stdout=$'Outputs modified lines\n'
summary="Trim whitespace from beginning and end of a stream"
summaryComputed="true"
usage="textTrimBoth [ --help ]"
