#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="searchString - String. Thing to search for."$'\n'"replaceString - String. Thing to replace search string with."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Replaces the first and only the first occurrence of a pattern in a line with a replacement string."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="textReplaceFirst"
fnMarker="textreplacefirst"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="216"
rawComment="Replaces the first and only the first occurrence of a pattern in a line with a replacement string."$'\n'"Without arguments, displays help."$'\n'"Argument: searchString - String. Thing to search for."$'\n'"Argument: replaceString - String. Thing to replace search string with."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs modified lines"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="216"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines"$'\n'""
summary="Replaces the first and only the first occurrence of a"
summaryComputed="true"
usage="textReplaceFirst [ searchString ] [ replaceString ]"
