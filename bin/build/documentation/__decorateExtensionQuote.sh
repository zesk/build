#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Double-quote all arguments as properly quoted bash string.\nMostly $ and " are problematic within a string.\n\n'
descriptionLineCount="3"
example=$'    > decorate quote "$title"\n    "Can\'t believe it was only \\$0.99?"\n'
file="bin/build/tools/decorate/core.sh"
fn="decorate quote"
fnMarker="__decorateextensionquote"
foundNames=([0]="fn" [1]="summary" [2]="example" [3]="requires")
line="346"
original="__decorateExtensionQuote"
rawComment=$'fn: decorate quote\nSummary: Double-quote all arguments\nDouble-quote all arguments as properly quoted bash string.\nExample:     > decorate quote "$title"\nExample:     "Can\'t believe it was only \\$0.99?"\nMostly $ and " are problematic within a string.\nRequires: printf decorate\n\n'
requires=$'printf decorate\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="3725cb28e12948a0b0e952bb332cba7a3044c792"
sourceLine="346"
summary="Double-quote all arguments"
summaryComputed=""
usage="__decorateExtensionQuote"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorate quote'$'\e''[0m'$'\n'''$'\n''Double-quote all arguments as properly quoted bash string.'$'\n''Mostly $ and " are problematic within a string.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    > decorate quote "$title"'$'\n''    "Can'\''t believe it was only \$0.99?"'
# shellcheck disable=SC2016
helpPlain='Usage: decorate quote'$'\n'''$'\n''Double-quote all arguments as properly quoted bash string.'$'\n''Mostly $ and " are problematic within a string.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    > decorate quote "$title"'$'\n''    "Can'\''t believe it was only \$0.99?"'
documentationPath="documentation/source/tools/decorate.md"
