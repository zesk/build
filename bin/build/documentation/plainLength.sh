#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="text - EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input."$'\n'""
base="text.sh"
description="Length of an unformatted string"$'\n'""
file="bin/build/tools/text.sh"
fn="plainLength"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768695708"
stdin="A file to determine the plain-text length"$'\n'""
stdout="\`UnsignedInteger\`. Length of the plain characters in the input arguments."$'\n'""
summary="Length of an unformatted string"
usage="plainLength [ text ]"
