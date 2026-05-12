#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'characterWidth - Characters to align right\ntext ... - Text to align right\n--help - Flag. Optional. Display this help.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Format text and align it right using spaces.\n\n'
descriptionLineCount="2"
example=$'    printf "%s: %s\\n" "$(textAlignRight 20 Name)" "$name"\n    printf "%s: %s\\n" "$(textAlignRight 20 Profession)" "$occupation"\n                Name: Juanita\n          Profession: Engineer\n'
file="bin/build/tools/text.sh"
fn="textAlignRight"
fnMarker="textalignright"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="1264"
rawComment=$'Format text and align it right using spaces.\nSummary: align text right\nArgument: characterWidth - Characters to align right\nArgument: text ... - Text to align right\nArgument: --help - Flag. Optional. Display this help.\nExample:     printf "%s: %s\\n" "$(textAlignRight 20 Name)" "$name"\nExample:     printf "%s: %s\\n" "$(textAlignRight 20 Profession)" "$occupation"\nExample:                 Name: Juanita\nExample:           Profession: Engineer\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1264"
summary="align text right"
summaryComputed=""
usage="textAlignRight [ characterWidth ] [ text ... ] [ --help ]"
