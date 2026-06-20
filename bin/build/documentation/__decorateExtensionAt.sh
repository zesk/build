#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'x - Integer. Console X offset\ny - Integer. Console Y offset\ntext ... - EmptyString. Text line to output at the x,y console location. Additional lines are placed below the previous line.\n'
base="big.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Experimental\nPlace text at a position on the console.\n\n'
descriptionLineCount="3"
file="bin/build/tools/decorate/big.sh"
fn="decorate at"
fnMarker="__decorateextensionat"
foundNames=([0]="fn" [1]="argument")
line="98"
original="__decorateExtensionAt"
rawComment=$'Experimental\nfn: decorate at\nPlace text at a position on the console.\nArgument: x - Integer. Console X offset\nArgument: y - Integer. Console Y offset\nArgument: text ... - EmptyString. Text line to output at the x,y console location. Additional lines are placed below the previous line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/big.sh"
sourceHash="77fd1e59dc735f629c2a15dbbfe4689834a12f59"
sourceLine="98"
summary="Experimental"
summaryComputed="true"
usage="decorate at [ x ] [ y ] [ text ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorate at'$'\e''[0m '$'\e''[[(blue)]m[ x ]'$'\e''[0m '$'\e''[[(blue)]m[ y ]'$'\e''[0m '$'\e''[[(blue)]m[ text ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mx         '$'\e''[[(value)]mInteger. Console X offset'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]my         '$'\e''[[(value)]mInteger. Console Y offset'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext ...  '$'\e''[[(value)]mEmptyString. Text line to output at the x,y console location. Additional lines are placed below the previous line.'$'\e''[[(reset)]m'$'\n'''$'\n''Experimental'$'\n''Place text at a position on the console.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: decorate at [ x ] [ y ] [ text ... ]'$'\n'''$'\n''    x         Integer. Console X offset'$'\n''    y         Integer. Console Y offset'$'\n''    text ...  EmptyString. Text line to output at the x,y console location. Additional lines are placed below the previous line.'$'\n'''$'\n''Experimental'$'\n''Place text at a position on the console.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/cursor.md"
