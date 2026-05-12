#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'number - Number. Required. An integer or floating point number\nsingular - String. Required. The singular form of a noun\nlocalePlural - String. Optional. The localePlural form of a noun. If not specified uses `singular` plus an ess.\n'
base="text.sh"
count=""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Plural word which includes the numeric prefix and the noun.\n\n'
descriptionLineCount="2"
example=$'    count=$(fileLineCount "$foxSightings") || return $?\n    printf "We saw %s.\\n" "$(localePluralWord "$count" fox foxes)"\n'
file="bin/build/tools/text.sh"
fn="localePluralWord"
fnMarker="localepluralword"
foundNames=([0]="argument" [1]="example" [2]="stdout")
line="805"
rawComment=$'Plural word which includes the numeric prefix and the noun.\nArgument: number - Number. Required. An integer or floating point number\nArgument: singular - String. Required. The singular form of a noun\nArgument: localePlural - String. Optional. The localePlural form of a noun. If not specified uses `singular` plus an ess.\nExample:     count=$(fileLineCount "$foxSightings") || return $?\nExample:     printf "We saw %s.\\n" "$(localePluralWord "$count" fox foxes)"\nstdout: `String`. The number (direct) and the localePlural form for non-1 values. e.g. `$(localePluralWord 2 potato potatoes)` = `2 potatoes`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="805"
stdout=$'`String`. The number (direct) and the localePlural form for non-1 values. e.g. `$(localePluralWord 2 potato potatoes)` = `2 potatoes`\n'
summary="Plural word which includes the numeric prefix and the noun."
summaryComputed="true"
usage="localePluralWord number singular [ localePlural ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlocalePluralWord'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mnumber'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msingular'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ localePlural ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mnumber        '$'\e''[[(value)]mNumber. Required. An integer or floating point number'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msingular      '$'\e''[[(value)]mString. Required. The singular form of a noun'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mlocalePlural  '$'\e''[[(value)]mString. Optional. The localePlural form of a noun. If not specified uses '$'\e''[[(code)]msingular'$'\e''[[(reset)]m plus an ess.'$'\e''[[(reset)]m'$'\n'''$'\n''Plural word which includes the numeric prefix and the noun.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n'''$'\e''[[(code)]mString'$'\e''[[(reset)]m. The number (direct) and the localePlural form for non-1 values. e.g. '$'\e''[[(code)]m$(localePluralWord 2 potato potatoes)'$'\e''[[(reset)]m = '$'\e''[[(code)]m2 potatoes'$'\e''[[(reset)]m'$'\n'''$'\n''Example:'$'\n''    count=$(fileLineCount "$foxSightings") || return $?'$'\n''    printf "We saw %s.\n" "$(localePluralWord "$count" fox foxes)"'
# shellcheck disable=SC2016
helpPlain='Usage: localePluralWord number singular [ localePlural ]'$'\n'''$'\n''    number        Number. Required. An integer or floating point number'$'\n''    singular      String. Required. The singular form of a noun'$'\n''    localePlural  String. Optional. The localePlural form of a noun. If not specified uses singular plus an ess.'$'\n'''$'\n''Plural word which includes the numeric prefix and the noun.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String. The number (direct) and the localePlural form for non-1 values. e.g. $(localePluralWord 2 potato potatoes) = 2 potatoes'$'\n'''$'\n''Example:'$'\n''    count=$(fileLineCount "$foxSightings") || return $?'$'\n''    printf "We saw %s.\n" "$(localePluralWord "$count" fox foxes)"'
documentationPath="documentation/source/tools/text.md"
