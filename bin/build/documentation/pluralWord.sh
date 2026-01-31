#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Plural word which includes the numeric prefix and the noun."$'\n'"Argument: number - Number. Required. An integer or floating point number"$'\n'"Argument: singular - String. Required. The singular form of a noun"$'\n'"Argument: plural - String. Optional. The plural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'"Example:     count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"Example:     printf \"We saw %s.\\n\" \"\$(pluralWord \"\$count\" fox foxes)\""$'\n'"stdout: \`String\`. The number (direct) and the plural form for non-1 values. e.g. \`\$(pluralWord 2 potato potatoes)\` = \`2 potatoes\`"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Plural word which includes the numeric prefix and the noun."$'\n'"Argument: number - Number. Required. An integer or floating point number"$'\n'"Argument: singular - String. Required. The singular form of a noun"$'\n'"Argument: plural - String. Optional. The plural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'"Example:     count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"Example:     printf \"We saw %s.\\n\" \"\$(pluralWord \"\$count\" fox foxes)\""$'\n'"stdout: \`String\`. The number (direct) and the plural form for non-1 values. e.g. \`\$(pluralWord 2 potato potatoes)\` = \`2 potatoes\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Plural word which includes the numeric prefix and the noun."
usage="pluralWord"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpluralWord'$'\e''[0m'$'\n'''$'\n''Plural word which includes the numeric prefix and the noun.'$'\n''Argument: number - Number. Required. An integer or floating point number'$'\n''Argument: singular - String. Required. The singular form of a noun'$'\n''Argument: plural - String. Optional. The plural form of a noun. If not specified uses '$'\e''[[(code)]msingular'$'\e''[[(reset)]m plus an ess.'$'\n''Example:     count=$(fileLineCount "$foxSightings") || return $?'$'\n''Example:     printf "We saw %s.\n" "$(pluralWord "$count" fox foxes)"'$'\n''stdout: '$'\e''[[(code)]mString'$'\e''[[(reset)]m. The number (direct) and the plural form for non-1 values. e.g. '$'\e''[[(code)]m$(pluralWord 2 potato potatoes)'$'\e''[[(reset)]m = '$'\e''[[(code)]m2 potatoes'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pluralWord'$'\n'''$'\n''Plural word which includes the numeric prefix and the noun.'$'\n''Argument: number - Number. Required. An integer or floating point number'$'\n''Argument: singular - String. Required. The singular form of a noun'$'\n''Argument: plural - String. Optional. The plural form of a noun. If not specified uses singular plus an ess.'$'\n''Example:     count=$(fileLineCount "$foxSightings") || return $?'$'\n''Example:     printf "We saw %s.\n" "$(pluralWord "$count" fox foxes)"'$'\n''stdout: String. The number (direct) and the plural form for non-1 values. e.g. $(pluralWord 2 potato potatoes) = 2 potatoes'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.501
