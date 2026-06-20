#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'size - UnsignedInteger. Optional. Size to display.\n'
base="size.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Size converted to kilo, mega, giga bytes."
descriptionLineCount=""
example=$'    > decorate size 169204\n    165k (169204)\n    > decorate size 16920400232\n    15G (16920400232)\n'
file="bin/build/tools/decorate/size.sh"
fn="decorate size"
fnMarker="__decorateextensionsize"
foundNames=([0]="fn" [1]="summary" [2]="argument" [3]="example" [4]="requires")
line="14"
original="__decorateExtensionSize"
rawComment=$'fn: decorate size\nSummary: Size converted to kilo, mega, giga bytes.\nArgument: size - UnsignedInteger. Optional. Size to display.\nExample:     > decorate size 169204\nExample:     165k (169204)\nExample:     > decorate size 16920400232\nExample:     15G (16920400232)\nRequires: printf decorate isUnsignedInteger\n\n'
requires=$'printf decorate isUnsignedInteger\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/size.sh"
sourceHash="3eccc94d9b9ef5fdaa9f3089496b271ab19fc3e5"
sourceLine="14"
summary="Size converted to kilo, mega, giga bytes."
summaryComputed=""
usage="decorate size [ size ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorate size'$'\e''[0m '$'\e''[[(blue)]m[ size ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]msize  '$'\e''[[(value)]mUnsignedInteger. Optional. Size to display.'$'\e''[[(reset)]m'$'\n'''$'\n''Size converted to kilo, mega, giga bytes.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    > decorate size 169204'$'\n''    165k (169204)'$'\n''    > decorate size 16920400232'$'\n''    15G (16920400232)'
# shellcheck disable=SC2016
helpPlain='Usage: decorate size [ size ]'$'\n'''$'\n''    size  UnsignedInteger. Optional. Size to display.'$'\n'''$'\n''Size converted to kilo, mega, giga bytes.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    > decorate size 169204'$'\n''    165k (169204)'$'\n''    > decorate size 16920400232'$'\n''    15G (16920400232)'
documentationPath="documentation/source/tools/decorate.md"
