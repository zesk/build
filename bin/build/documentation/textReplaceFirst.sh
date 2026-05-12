#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'searchString - String. Thing to search for.\nreplaceString - String. Thing to replace search string with.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Replaces the first and only the first occurrence of a pattern in a line with a replacement string.\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="textReplaceFirst"
fnMarker="textreplacefirst"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="216"
rawComment=$'Replaces the first and only the first occurrence of a pattern in a line with a replacement string.\nWithout arguments, displays help.\nArgument: searchString - String. Thing to search for.\nArgument: replaceString - String. Thing to replace search string with.\nstdin: Reads lines from stdin until EOF\nstdout: Outputs modified lines\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="216"
stdin=$'Reads lines from stdin until EOF\n'
stdout=$'Outputs modified lines\n'
summary="Replaces the first and only the first occurrence of a"
summaryComputed="true"
usage="textReplaceFirst [ searchString ] [ replaceString ]"
