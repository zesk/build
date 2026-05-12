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
