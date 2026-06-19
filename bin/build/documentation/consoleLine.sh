#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'alternateChar - String. Optional. Use an alternate character or string output\noffset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is `0`)\n'
base="line.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output a bar as wide as the console using the `=` symbol.\n\n'
descriptionLineCount="2"
example=$'    decorate success $(consoleLine =-)\n    decorate success $(consoleLine "- Success ")\n    decorate magenta $(consoleLine +-)\n'
file="bin/build/tools/decorate/line.sh"
fn="consoleLine"
fnMarker="consoleline"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="example")
line="14"
rawComment=$'Summary: Output a bar as wide as the console\nOutput a bar as wide as the console using the `=` symbol.\nArgument: alternateChar - String. Optional. Use an alternate character or string output\nArgument: offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is `0`)\nSee: consoleColumns\nExample:     decorate success $(consoleLine =-)\nExample:     decorate success $(consoleLine "- Success ")\nExample:     decorate magenta $(consoleLine +-)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'consoleColumns\n'
sourceFile="bin/build/tools/decorate/line.sh"
sourceHash="1f11a1a79d595a6144fdc9d230d37898d937db22"
sourceLine="14"
summary="Output a bar as wide as the console"
summaryComputed=""
usage="consoleLine [ alternateChar ] [ offset ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleLine'$'\e''[0m '$'\e''[[(blue)]m[ alternateChar ]'$'\e''[0m '$'\e''[[(blue)]m[ offset ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]malternateChar  '$'\e''[[(value)]mString. Optional. Use an alternate character or string output'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]moffset         '$'\e''[[(value)]mInteger. Optional. an integer offset to increase or decrease the size of the bar (default is '$'\e''[[(code)]m0'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n'''$'\n''Output a bar as wide as the console using the '$'\e''[[(code)]m='$'\e''[[(reset)]m symbol.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    decorate success $(consoleLine =-)'$'\n''    decorate success $(consoleLine "- Success ")'$'\n''    decorate magenta $(consoleLine +-)'
# shellcheck disable=SC2016
helpPlain='Usage: consoleLine [ alternateChar ] [ offset ]'$'\n'''$'\n''    alternateChar  String. Optional. Use an alternate character or string output'$'\n''    offset         Integer. Optional. an integer offset to increase or decrease the size of the bar (default is 0)'$'\n'''$'\n''Output a bar as wide as the console using the = symbol.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    decorate success $(consoleLine =-)'$'\n''    decorate success $(consoleLine "- Success ")'$'\n''    decorate magenta $(consoleLine +-)'
documentationPath="documentation/source/tools/decoration.md"
