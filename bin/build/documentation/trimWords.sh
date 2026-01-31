#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Remove words from the end of a phrase"$'\n'"Argument: wordCount - PositiveInteger. Words to output"$'\n'"Argument: word0 ... - EmptyString. One or more words to output"$'\n'"Example:     printf \"%s: %s\\n\" \"Summary:\" \"\$(trimWords 10 \$description)\""$'\n'"Tested: No"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Remove words from the end of a phrase"$'\n'"Argument: wordCount - PositiveInteger. Words to output"$'\n'"Argument: word0 ... - EmptyString. One or more words to output"$'\n'"Example:     printf \"%s: %s\\n\" \"Summary:\" \"\$(trimWords 10 \$description)\""$'\n'"Tested: No"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Remove words from the end of a phrase"
usage="trimWords"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtrimWords'$'\e''[0m'$'\n'''$'\n''Remove words from the end of a phrase'$'\n''Argument: wordCount - PositiveInteger. Words to output'$'\n''Argument: word0 ... - EmptyString. One or more words to output'$'\n''Example:     printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"'$'\n''Tested: No'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: trimWords'$'\n'''$'\n''Remove words from the end of a phrase'$'\n''Argument: wordCount - PositiveInteger. Words to output'$'\n''Argument: word0 ... - EmptyString. One or more words to output'$'\n''Example:     printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"'$'\n''Tested: No'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.498
