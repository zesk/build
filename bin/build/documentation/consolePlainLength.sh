#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="text - EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Length of an unformatted string"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="consolePlainLength"
fnMarker="consoleplainlength"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="929"
rawComment="Length of an unformatted string"$'\n'"Argument: text - EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input."$'\n'"stdin: A file to determine the plain-text length"$'\n'"stdout: \`UnsignedInteger\`. Length of the plain characters in the input arguments."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="929"
stdin="A file to determine the plain-text length"$'\n'""
stdout="\`UnsignedInteger\`. Length of the plain characters in the input arguments."$'\n'""
summary="Length of an unformatted string"
summaryComputed="true"
usage="consolePlainLength [ text ]"
