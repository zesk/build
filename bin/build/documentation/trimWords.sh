#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="wordCount - PositiveInteger. Words to output"$'\n'"word0 ... - EmptyString. One or more words to output"$'\n'""
base="text.sh"
description="Remove words from the end of a phrase"$'\n'""
example="    printf \"%s: %s\\n\" \"Summary:\" \"\$(trimWords 10 \$description)\""$'\n'""
exitCode="0"
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="example" [2]="tested")
rawComment="Remove words from the end of a phrase"$'\n'"Argument: wordCount - PositiveInteger. Words to output"$'\n'"Argument: word0 ... - EmptyString. One or more words to output"$'\n'"Example:     printf \"%s: %s\\n\" \"Summary:\" \"\$(trimWords 10 \$description)\""$'\n'"Tested: No"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769276468"
summary="Remove words from the end of a phrase"
tested="No"$'\n'""
usage="trimWords [ wordCount ] [ word0 ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mtrimWords'$'\e''[0m '$'\e''[[blue]m[ wordCount ]'$'\e''[0m '$'\e''[[blue]m[ word0 ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mwordCount  '$'\e''[[value]mPositiveInteger. Words to output'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mword0 ...  '$'\e''[[value]mEmptyString. One or more words to output'$'\e''[[reset]m'$'\n'''$'\n''Remove words from the end of a phrase'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: trimWords [ wordCount ] [ word0 ... ]'$'\n'''$'\n''    wordCount  PositiveInteger. Words to output'$'\n''    word0 ...  EmptyString. One or more words to output'$'\n'''$'\n''Remove words from the end of a phrase'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"'$'\n'''
