#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'text - EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Length of an unformatted string\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="consolePlainLength"
fnMarker="consoleplainlength"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="932"
rawComment=$'Length of an unformatted string\nArgument: text - EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input.\nstdin: A file to determine the plain-text length\nstdout: `UnsignedInteger`. Length of the plain characters in the input arguments.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="932"
stdin=$'A file to determine the plain-text length\n'
stdout=$'`UnsignedInteger`. Length of the plain characters in the input arguments.\n'
summary="Length of an unformatted string"
summaryComputed="true"
usage="consolePlainLength [ text ]"
