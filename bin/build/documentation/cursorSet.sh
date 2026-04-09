#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="x - UnsignedInteger. Required. Column to place the cursor."$'\n'"y - UnsignedInteger. Required. Row to place the cursor."$'\n'""
base="cursor.sh"
description="Move the cursor to x y"$'\n'""
file="bin/build/tools/cursor.sh"
fn="cursorSet"
foundNames=([0]="argument")
line="41"
lowerFn="cursorset"
rawComment="Move the cursor to x y"$'\n'"Argument: x - UnsignedInteger. Required. Column to place the cursor."$'\n'"Argument: y - UnsignedInteger. Required. Row to place the cursor."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/cursor.sh"
sourceHash="2dec7314dba47496bd20b7749aaa2d01645c0da7"
sourceLine="41"
summary="Move the cursor to x y"
summaryComputed="true"
usage="cursorSet x y"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcursorSet'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mx'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]my'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mx  '$'\e''[[(value)]mUnsignedInteger. Required. Column to place the cursor.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]my  '$'\e''[[(value)]mUnsignedInteger. Required. Row to place the cursor.'$'\e''[[(reset)]m'$'\n'''$'\n''Move the cursor to x y'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: cursorSet x y'$'\n'''$'\n''    x  UnsignedInteger. Required. Column to place the cursor.'$'\n''    y  UnsignedInteger. Required. Row to place the cursor.'$'\n'''$'\n''Move the cursor to x y'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/cursor.md"
