#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'leftStyle - String. Required. Style for left file lines\nrightStyle - String. Required. Style for right file lines\n'
base="diff.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Removes most diff character decoration and replaces with colors\n\n'
descriptionLineCount="2"
file="bin/build/tools/diff.sh"
fn="decorate diff"
fnMarker="__decorateextensiondiff"
foundNames=([0]="fn" [1]="summary" [2]="argument")
line="12"
original="__decorateExtensionDiff"
rawComment=$'fn: decorate diff\nSummary: Decoration for `diff -U0`\nRemoves most diff character decoration and replaces with colors\nArgument: leftStyle - String. Required. Style for left file lines\nArgument: rightStyle - String. Required. Style for right file lines\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/diff.sh"
sourceHash="5bd24ee67b35642dc7b13c2b36f2800f3b45750c"
sourceLine="12"
summary="Decoration for \`diff -U0\`"
summaryComputed=""
usage="decorate diff leftStyle rightStyle"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorate diff'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mleftStyle'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mrightStyle'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mleftStyle   '$'\e''[[(value)]mString. Required. Style for left file lines'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mrightStyle  '$'\e''[[(value)]mString. Required. Style for right file lines'$'\e''[[(reset)]m'$'\n'''$'\n''Removes most diff character decoration and replaces with colors'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: decorate diff leftStyle rightStyle'$'\n'''$'\n''    leftStyle   String. Required. Style for left file lines'$'\n''    rightStyle  String. Required. Style for right file lines'$'\n'''$'\n''Removes most diff character decoration and replaces with colors'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/decorate.md"
