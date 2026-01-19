#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="text - EmptyString. Required. Text to quote."$'\n'""
base="quote.sh"
depends="sed"$'\n'""
description="Quote bash strings for inclusion as single-quoted for eval"$'\n'""
example="    name=\"\$(quoteBashString \"\$name\")\""$'\n'""
file="bin/build/tools/quote.sh"
fn="quoteBashString"
foundNames=([0]="argument" [1]="output" [2]="depends" [3]="example")
output="string quoted and appropriate to assign to a value in the shell"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/quote.sh"
sourceModified="1768513812"
summary="Quote bash strings for inclusion as single-quoted for eval"
usage="quoteBashString text"
