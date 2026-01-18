#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="wordCount - PositiveInteger. Words to output"$'\n'"word0 ... - EmptyString. One or more words to output"$'\n'""
base="text.sh"
description="Remove words from the end of a phrase"$'\n'""$'\n'""$'\n'""
example="    printf \"%s: %s\\n\" \"Summary:\" \"\$(trimWords 10 \$description)\""$'\n'""
file="bin/build/tools/text.sh"
fn="trimWords"
foundNames=([0]="argument" [1]="example" [2]="tested")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768721469"
summary="Remove words from the end of a phrase"
tested="No"$'\n'""
usage="trimWords [ wordCount ] [ word0 ... ]"
