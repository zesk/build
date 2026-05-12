#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'needle - String. Required. String to replace.\nreplacement - EmptyString.  String to replace needle with.\nhaystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Replace all occurrences of a string within another string\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="textReplace"
fnMarker="textreplace"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="1213"
rawComment=$'Replace all occurrences of a string within another string\nArgument: needle - String. Required. String to replace.\nArgument: replacement - EmptyString.  String to replace needle with.\nArgument: haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input.\nstdin: If no haystack supplied reads from standard input and replaces the string on each line read.\nstdout: New string with needle replaced\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1213"
stdin=$'If no haystack supplied reads from standard input and replaces the string on each line read.\n'
stdout=$'New string with needle replaced\n'
summary="Replace all occurrences of a string within another string"
summaryComputed="true"
usage="textReplace needle [ replacement ] [ haystack ]"
