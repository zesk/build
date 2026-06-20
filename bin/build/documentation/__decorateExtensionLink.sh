#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'url - Required. Link to output to the console.\ntext - String. Optional. Text to output linked to `url`.\n'
base="console.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'decorate extension for `link`\n\n'
descriptionLineCount="2"
file="bin/build/tools/console.sh"
fn="decorate link"
fnMarker="__decorateextensionlink"
foundNames=([0]="summary" [1]="fn" [2]="argument")
line="277"
original="__decorateExtensionLink"
rawComment=$'Summary: decorate web links\ndecorate extension for `link`\nfn: decorate link\nArgument: url - Required. Link to output to the console.\nArgument: text - String. Optional. Text to output linked to `url`.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/console.sh"
sourceHash="0e80c2ac41033836c3905696efb51ddeab9575b8"
sourceLine="277"
summary="decorate web links"
summaryComputed=""
usage="decorate link url [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorate link'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]murl   '$'\e''[[(value)]mRequired. Link to output to the console.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext  '$'\e''[[(value)]mString. Optional. Text to output linked to '$'\e''[[(code)]murl'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''decorate extension for '$'\e''[[(code)]mlink'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: decorate link url [ text ]'$'\n'''$'\n''    url   Required. Link to output to the console.'$'\n''    text  String. Optional. Text to output linked to url.'$'\n'''$'\n''decorate extension for link'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/decorate.md"
