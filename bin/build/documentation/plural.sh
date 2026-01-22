#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="number - Number. Required. An integer or floating point number"$'\n'"singular - String. Required. The singular form of a noun"$'\n'"plural - String. Optional. The plural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'""
base="text.sh"
count=""
description="Outputs the \`singular\` value to standard out when the value of \`number\` is one."$'\n'"Otherwise, outputs the \`plural\` value to standard out."$'\n'""$'\n'"Short description: Output numeric messages which are grammatically accurate"$'\n'""$'\n'"Return Code: 1 - If count is non-numeric"$'\n'"Return Code: 0 - If count is numeric"$'\n'"Example:"$'\n'""
example="    count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"    printf \"We saw %d %s.\\n\" \"\$count\" \"\$(plural \"\$count\" fox foxes)\""$'\n'"    n=\$((\$(date +%s)) - start))"$'\n'"    printf \"That took %d %s\" \"\$n\" \"\$(plural \"\$n\" second seconds)\""$'\n'""
file="bin/build/tools/text.sh"
fn="plural"
foundNames=""
n=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdout="\`String\`. The plural form for non-1 values. e.g. \`\$(plural 2 potato potatoes)\` = \`potatoes\`"$'\n'""
summary="Outputs the \`singular\` value to standard out when the value"
usage="plural number singular [ plural ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mplural[0m [38;2;255;255;0m[35;48;2;0;0;0mnumber[0m[0m [38;2;255;255;0m[35;48;2;0;0;0msingular[0m[0m [94m[ plural ][0m

    [31mnumber    [1;97mNumber. Required. An integer or floating point number[0m
    [31msingular  [1;97mString. Required. The singular form of a noun[0m
    [94mplural    [1;97mString. Optional. The plural form of a noun. If not specified uses [38;2;0;255;0;48;2;0;0;0msingular[0m plus an ess.[0m

Outputs the [38;2;0;255;0;48;2;0;0;0msingular[0m value to standard out when the value of [38;2;0;255;0;48;2;0;0;0mnumber[0m is one.
Otherwise, outputs the [38;2;0;255;0;48;2;0;0;0mplural[0m value to standard out.

Short description: Output numeric messages which are grammatically accurate

Return Code: 1 - If count is non-numeric
Return Code: 0 - If count is numeric
Example:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mString[0m. The plural form for non-1 values. e.g. [38;2;0;255;0;48;2;0;0;0m$(plural 2 potato potatoes)[0m = [38;2;0;255;0;48;2;0;0;0mpotatoes[0m

Example:
    count=$(fileLineCount "$foxSightings") || return $?
    printf "We saw %d %s.\n" "$count" "$(plural "$count" fox foxes)"
    n=$(($(date +%s)) - start))
    printf "That took %d %s" "$n" "$(plural "$n" second seconds)"
'
# shellcheck disable=SC2016
helpPlain='Usage: plural number singular [ plural ]

    number    Number. Required. An integer or floating point number
    singular  String. Required. The singular form of a noun
    plural    String. Optional. The plural form of a noun. If not specified uses singular plus an ess.

Outputs the singular value to standard out when the value of number is one.
Otherwise, outputs the plural value to standard out.

Short description: Output numeric messages which are grammatically accurate

Return Code: 1 - If count is non-numeric
Return Code: 0 - If count is numeric
Example:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
String. The plural form for non-1 values. e.g. $(plural 2 potato potatoes) = potatoes

Example:
    count=$(fileLineCount "$foxSightings") || return $?
    printf "We saw %d %s.\n" "$count" "$(plural "$count" fox foxes)"
    n=$(($(date +%s)) - start))
    printf "That took %d %s" "$n" "$(plural "$n" second seconds)"
'
