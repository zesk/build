#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="text - String. Optional. Text to quote"$'\n'""
base="quote.sh"
description="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'""
example="    escapeDoubleQuotes \"Now I can't not include this in a bash string.\""$'\n'""
file="bin/build/tools/quote.sh"
fn="escapeDoubleQuotes"
foundNames=([0]="argument" [1]="output" [2]="example")
output="Single quotes are prefixed with a backslash"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/quote.sh"
sourceModified="1768513812"
summary="Quote strings for inclusion in shell quoted strings"
usage="escapeDoubleQuotes [ text ]"
