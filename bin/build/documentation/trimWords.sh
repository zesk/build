#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="wordCount - PositiveInteger. Words to output"$'\n'"word0 ... - EmptyString. One or more words to output"$'\n'""
base="text.sh"
description="Remove words from the end of a phrase"$'\n'""$'\n'""$'\n'""
example="    printf \"%s: %s\\n\" \"Summary:\" \"\$(trimWords 10 \$description)\""$'\n'""
file="bin/build/tools/text.sh"
fn="trimWords"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
summary="Remove words from the end of a phrase"
tested="No"$'\n'""
usage="trimWords [ wordCount ] [ word0 ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtrimWords[0m [94m[ wordCount ][0m [94m[ word0 ... ][0m

    [94mwordCount  [1;97mPositiveInteger. Words to output[0m
    [94mword0 ...  [1;97mEmptyString. One or more words to output[0m

Remove words from the end of a phrase

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"
'
# shellcheck disable=SC2016
helpPlain='Usage: trimWords [ wordCount ] [ word0 ... ]

    wordCount  PositiveInteger. Words to output
    word0 ...  EmptyString. One or more words to output

Remove words from the end of a phrase

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"
'
