#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sed.sh"
argument="text - EmptyString. Required. Text to quote"$'\n'""
base="sed.sh"
description="Quote a string to be used in a sed pattern on the command line."$'\n'""
example="    sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedPattern \"\$2\")/g\""$'\n'"    needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'""
file="bin/build/tools/sed.sh"
fn="quoteSedPattern"
foundNames=([0]="summary" [1]="argument" [2]="output" [3]="example" [4]="requires")
output="string quoted and appropriate to insert in a sed search or replacement phrase"$'\n'""
requires="printf sed usageDocument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/sed.sh"
sourceModified="1768683999"
summary="Quote sed search strings for shell use"$'\n'""
usage="quoteSedPattern text"
