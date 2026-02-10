#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="text - Text to quote"$'\n'""
base="text.sh"
description="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'""
example="    escapeQuotes \"Now I can't not include this in a bash string.\""$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="output" [2]="example" [3]="stdout")
output="Single quotes are prefixed with a backslash"$'\n'""
rawComment="Quote strings for inclusion in shell quoted strings"$'\n'"Argument: text - Text to quote"$'\n'"Output: Single quotes are prefixed with a backslash"$'\n'"Example:     {fn} \"Now I can't not include this in a bash string.\""$'\n'"Without arguments, displays help."$'\n'"stdout: The input text properly quoted"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="fe3f136d59f335809673a5a3a78c67c1bf585bf4"
stdout="The input text properly quoted"$'\n'""
summary="Quote strings for inclusion in shell quoted strings"
summaryComputed="true"
usage="escapeQuotes [ text ]"
