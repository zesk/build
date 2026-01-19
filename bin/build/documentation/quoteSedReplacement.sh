#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sed.sh"
argument="text - EmptyString. Required. Text to quote"$'\n'"separatorChar - The character used to separate the sed pattern and replacement. Defaults to \`/\`."$'\n'""
base="sed.sh"
description="Quote sed replacement strings for shell use"$'\n'""
example="    sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedReplacement \"\$2\")/g\""$'\n'"    needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'""
file="bin/build/tools/sed.sh"
fn="quoteSedReplacement"
foundNames=([0]="summary" [1]="argument" [2]="output" [3]="example" [4]="requires")
output="string quoted and appropriate to insert in a \`sed\` replacement phrase"$'\n'""
requires="printf sed usageDocument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/sed.sh"
sourceModified="1768683999"
summary="Quote sed replacement strings for shell use"$'\n'""
usage="quoteSedReplacement text [ separatorChar ]"
