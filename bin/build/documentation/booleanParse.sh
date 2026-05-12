#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument="none"
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Parses text and determines if it\'s true-ish\n\nWithout arguments, displays help.\n\n'
descriptionLineCount="4"
file="bin/build/tools/text.sh"
fn="booleanParse"
fnMarker="booleanparse"
foundNames=([0]="return_code" [1]="requires")
line="155"
rawComment=$'Parses text and determines if it\'s true-ish\nReturn Code: 0 - true\nReturn Code: 1 - false\nReturn Code: 2 - Neither\nRequires: stringLowercase helpArgument\nWithout arguments, displays help.\nReturn code: - `0` - Text is plain\nReturn code: - `1` - Text contains non-plain characters\n\n'
requires=$'stringLowercase helpArgument\n'
return_code=$'0 - true\n1 - false\n2 - Neither\n- `0` - Text is plain\n- `1` - Text contains non-plain characters\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="155"
summary="Parses text and determines if it's true-ish"
summaryComputed="true"
usage="booleanParse"
