#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="wordCount - PositiveInteger. Words to output"$'\n'"word0 ... - EmptyString. One or more words to output"$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove words from the end of a phrase"$'\n'""$'\n'""
descriptionLineCount="2"
example="    printf \"%s: %s\\n\" \"Summary:\" \"\$(stringTrimWords 10 \$description)\""$'\n'""
file="bin/build/tools/text.sh"
fn="stringTrimWords"
fnMarker="stringtrimwords"
foundNames=([0]="argument" [1]="example" [2]="tested")
line="579"
rawComment="Remove words from the end of a phrase"$'\n'"Argument: wordCount - PositiveInteger. Words to output"$'\n'"Argument: word0 ... - EmptyString. One or more words to output"$'\n'"Example:     printf \"%s: %s\\n\" \"Summary:\" \"\$(stringTrimWords 10 \$description)\""$'\n'"Tested: No"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="579"
summary="Remove words from the end of a phrase"
summaryComputed="true"
tested="No"$'\n'""
usage="stringTrimWords [ wordCount ] [ word0 ... ]"
