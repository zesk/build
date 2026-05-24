#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'x - UnsignedInteger. Required. Column to place the cursor.\ny - UnsignedInteger. Required. Row to place the cursor.\n'
base="cursor.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Move the cursor to x y\n\n'
descriptionLineCount="2"
file="bin/build/tools/cursor.sh"
fn="cursorSet"
fnMarker="cursorset"
foundNames=([0]="argument")
line="41"
rawComment=$'Move the cursor to x y\nArgument: x - UnsignedInteger. Required. Column to place the cursor.\nArgument: y - UnsignedInteger. Required. Row to place the cursor.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/cursor.sh"
sourceHash="168857d25babe32c4b67235ad26a6f7d090b0a94"
sourceLine="41"
summary="Move the cursor to x y"
summaryComputed="true"
usage="cursorSet x y"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcursorSet'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mx'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]my'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mx  '$'\e''[[(value)]mUnsignedInteger. Required. Column to place the cursor.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]my  '$'\e''[[(value)]mUnsignedInteger. Required. Row to place the cursor.'$'\e''[[(reset)]m'$'\n'''$'\n''Move the cursor to x y'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: cursorSet x y'$'\n'''$'\n''    x  UnsignedInteger. Required. Column to place the cursor.'$'\n''    y  UnsignedInteger. Required. Row to place the cursor.'$'\n'''$'\n''Move the cursor to x y'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/cursor.md"
