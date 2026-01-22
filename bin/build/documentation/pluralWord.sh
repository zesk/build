#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="number - Number. Required. An integer or floating point number"$'\n'"singular - String. Required. The singular form of a noun"$'\n'"plural - String. Optional. The plural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'""
base="text.sh"
count=""
description="Plural word which includes the numeric prefix and the noun."$'\n'""
example="    count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"    printf \"We saw %s.\\n\" \"\$(pluralWord \"\$count\" fox foxes)\""$'\n'""
file="bin/build/tools/text.sh"
fn="pluralWord"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
stdout="\`String\`. The number (direct) and the plural form for non-1 values. e.g. \`\$(pluralWord 2 potato potatoes)\` = \`2 potatoes\`"$'\n'""
summary="Plural word which includes the numeric prefix and the noun."
usage="pluralWord number singular [ plural ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpluralWord[0m [38;2;255;255;0m[35;48;2;0;0;0mnumber[0m[0m [38;2;255;255;0m[35;48;2;0;0;0msingular[0m[0m [94m[ plural ][0m

    [31mnumber    [1;97mNumber. Required. An integer or floating point number[0m
    [31msingular  [1;97mString. Required. The singular form of a noun[0m
    [94mplural    [1;97mString. Optional. The plural form of a noun. If not specified uses [38;2;0;255;0;48;2;0;0;0msingular[0m plus an ess.[0m

Plural word which includes the numeric prefix and the noun.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mString[0m. The number (direct) and the plural form for non-1 values. e.g. [38;2;0;255;0;48;2;0;0;0m$(pluralWord 2 potato potatoes)[0m = [38;2;0;255;0;48;2;0;0;0m2 potatoes[0m

Example:
    count=$(fileLineCount "$foxSightings") || return $?
    printf "We saw %s.\n" "$(pluralWord "$count" fox foxes)"
'
# shellcheck disable=SC2016
helpPlain='Usage: pluralWord number singular [ plural ]

    number    Number. Required. An integer or floating point number
    singular  String. Required. The singular form of a noun
    plural    String. Optional. The plural form of a noun. If not specified uses singular plus an ess.

Plural word which includes the numeric prefix and the noun.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
String. The number (direct) and the plural form for non-1 values. e.g. $(pluralWord 2 potato potatoes) = 2 potatoes

Example:
    count=$(fileLineCount "$foxSightings") || return $?
    printf "We saw %s.\n" "$(pluralWord "$count" fox foxes)"
'
