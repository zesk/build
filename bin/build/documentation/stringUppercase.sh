#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.\n--help - Flag. Optional. Display this help.\ntext - EmptyString. Required. text to convert to uppercase\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Convert text to uppercase\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringUppercase"
fnMarker="stringuppercase"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
line="892"
rawComment=$'Convert text to uppercase\nArgument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.\nArgument: --help - Flag. Optional. Display this help.\nArgument: text - EmptyString. Required. text to convert to uppercase\nstdout: `String`. The stringUppercase version of the `text`.\nRequires: tr\n\n'
requires=$'tr\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="892"
stdout=$'`String`. The stringUppercase version of the `text`.\n'
summary="Convert text to uppercase"
summaryComputed="true"
usage="stringUppercase [ -- ] [ --help ] text"
