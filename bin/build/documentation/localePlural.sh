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
