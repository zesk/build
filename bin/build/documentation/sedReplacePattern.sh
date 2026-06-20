#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'searchPattern - String. Required. The string to search for.\nreplacePattern - String. Required. The replacement to replace with.\n'
base="sed.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Quote a sed command for search and replace\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
file="bin/build/tools/sed.sh"
fn="sedReplacePattern"
fnMarker="sedreplacepattern"
foundNames=([0]="argument")
line="19"
original="sedReplacePattern"
rawComment=$'Quote a sed command for search and replace\nArgument: searchPattern - String. Required. The string to search for.\nArgument: replacePattern - String. Required. The replacement to replace with.\nWithout arguments, displays help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/sed.sh"
sourceHash="f0fc6b83d684caf722f5b07d53b68ae6ac5fa68a"
sourceLine="19"
summary="Quote a sed command for search and replace"
summaryComputed="true"
usage="sedReplacePattern searchPattern replacePattern"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]msedReplacePattern'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msearchPattern'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mreplacePattern'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msearchPattern   '$'\e''[[(value)]mString. Required. The string to search for.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mreplacePattern  '$'\e''[[(value)]mString. Required. The replacement to replace with.'$'\e''[[(reset)]m'$'\n'''$'\n''Quote a sed command for search and replace'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: sedReplacePattern searchPattern replacePattern'$'\n'''$'\n''    searchPattern   String. Required. The string to search for.'$'\n''    replacePattern  String. Required. The replacement to replace with.'$'\n'''$'\n''Quote a sed command for search and replace'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/quote.md"
