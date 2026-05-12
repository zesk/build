#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'number - Number. Required. An integer or floating point number\nsingular - String. Required. The singular form of a noun\nlocalePlural - String. Optional. The localePlural form of a noun. If not specified uses `singular` plus an ess.\n'
base="text.sh"
count=""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs the `singular` value to standard out when the value of `number` is one.\nOtherwise, outputs the `localePlural` value to standard out.\n\nExample:\n\n'
descriptionLineCount="5"
example=$'    count=$(fileLineCount "$foxSightings") || return $?\n    printf "We saw %d %s.\\n" "$count" "$(localePlural "$count" fox foxes)"\n    n=$(($(date +%s)) - start))\n    printf "That took %d %s" "$n" "$(localePlural "$n" second seconds)"\n'
file="bin/build/tools/text.sh"
fn="localePlural"
fnMarker="localeplural"
foundNames=([0]="short_description" [1]="argument" [2]="return_code" [3]="example" [4]="stdout")
line="833"
n=""
rawComment=$'Outputs the `singular` value to standard out when the value of `number` is one.\nOtherwise, outputs the `localePlural` value to standard out.\nShort description: Output numeric messages which are grammatically accurate\nArgument: number - Number. Required. An integer or floating point number\nArgument: singular - String. Required. The singular form of a noun\nArgument: localePlural - String. Optional. The localePlural form of a noun. If not specified uses `singular` plus an ess.\nReturn Code: 1 - If count is non-numeric\nReturn Code: 0 - If count is numeric\nExample:     count=$(fileLineCount "$foxSightings") || return $?\nExample:     printf "We saw %d %s.\\n" "$count" "$(localePlural "$count" fox foxes)"\nExample:\nExample:     n=$(($(date +%s)) - start))\nExample:     printf "That took %d %s" "$n" "$(localePlural "$n" second seconds)"\nstdout: `String`. The localePlural form for non-1 values. e.g. `$(localePlural 2 potato potatoes)` = `potatoes`\n\n'
return_code=$'1 - If count is non-numeric\n0 - If count is numeric\n'
short_description=$'Output numeric messages which are grammatically accurate\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="833"
stdout=$'`String`. The localePlural form for non-1 values. e.g. `$(localePlural 2 potato potatoes)` = `potatoes`\n'
summary="Outputs the \`singular\` value to standard out when the value"
summaryComputed="true"
usage="localePlural number singular [ localePlural ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlocalePlural'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mnumber'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msingular'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ localePlural ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mnumber        '$'\e''[[(value)]mNumber. Required. An integer or floating point number'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msingular      '$'\e''[[(value)]mString. Required. The singular form of a noun'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mlocalePlural  '$'\e''[[(value)]mString. Optional. The localePlural form of a noun. If not specified uses '$'\e''[[(code)]msingular'$'\e''[[(reset)]m plus an ess.'$'\e''[[(reset)]m'$'\n'''$'\n''Outputs the '$'\e''[[(code)]msingular'$'\e''[[(reset)]m value to standard out when the value of '$'\e''[[(code)]mnumber'$'\e''[[(reset)]m is one.'$'\n''Otherwise, outputs the '$'\e''[[(code)]mlocalePlural'$'\e''[[(reset)]m value to standard out.'$'\n'''$'\n''Example:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If count is non-numeric'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If count is numeric'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n'''$'\e''[[(code)]mString'$'\e''[[(reset)]m. The localePlural form for non-1 values. e.g. '$'\e''[[(code)]m$(localePlural 2 potato potatoes)'$'\e''[[(reset)]m = '$'\e''[[(code)]mpotatoes'$'\e''[[(reset)]m'$'\n'''$'\n''Example:'$'\n''    count=$(fileLineCount "$foxSightings") || return $?'$'\n''    printf "We saw %d %s.\n" "$count" "$(localePlural "$count" fox foxes)"'$'\n''    n=$(($(date +%s)) - start))'$'\n''    printf "That took %d %s" "$n" "$(localePlural "$n" second seconds)"'
# shellcheck disable=SC2016
helpPlain='Usage: localePlural number singular [ localePlural ]'$'\n'''$'\n''    number        Number. Required. An integer or floating point number'$'\n''    singular      String. Required. The singular form of a noun'$'\n''    localePlural  String. Optional. The localePlural form of a noun. If not specified uses singular plus an ess.'$'\n'''$'\n''Outputs the singular value to standard out when the value of number is one.'$'\n''Otherwise, outputs the localePlural value to standard out.'$'\n'''$'\n''Example:'$'\n'''$'\n''Return codes:'$'\n''- 1 - If count is non-numeric'$'\n''- 0 - If count is numeric'$'\n'''$'\n''Writes to stdout:'$'\n''String. The localePlural form for non-1 values. e.g. $(localePlural 2 potato potatoes) = potatoes'$'\n'''$'\n''Example:'$'\n''    count=$(fileLineCount "$foxSightings") || return $?'$'\n''    printf "We saw %d %s.\n" "$count" "$(localePlural "$count" fox foxes)"'$'\n''    n=$(($(date +%s)) - start))'$'\n''    printf "That took %d %s" "$n" "$(localePlural "$n" second seconds)"'
documentationPath="documentation/source/tools/text.md"
