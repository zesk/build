#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="text - Text to quote"$'\n'""
base="text.sh"
description="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'""
example="    escapeQuotes \"Now I can't not include this in a bash string.\""$'\n'""
file="bin/build/tools/text.sh"
fn="escapeQuotes"
foundNames=([0]="argument" [1]="output" [2]="example" [3]="stdout")
output="Single quotes are prefixed with a backslash"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768686587"
stdout="The input text properly quoted"$'\n'""
summary="Quote strings for inclusion in shell quoted strings"
usage="escapeQuotes [ text ]"
