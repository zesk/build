#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
argument="text - EmptyString. Required. Text to quote."$'\n'""
base="quote.sh"
description="Quote grep -e patterns for shell use"$'\n'""$'\n'"Without arguments, displays help."$'\n'""
example="    grep -e \"\$(quoteGrepPattern \"\$pattern\")\" < \"\$filterFile\""$'\n'""
fn="quoteGrepPattern"
foundNames=([0]="quotes" [1]="argument" [2]="output" [3]="example" [4]="requires")
output="string quoted and appropriate to insert in a grep search or replacement phrase"$'\n'""
quotes="\" . [ ] | \\n with a backslash"$'\n'""
requires="printf sed"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/quote.sh"
summary="Quote grep -e patterns for shell use"
usage="quoteGrepPattern text"
