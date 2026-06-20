#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'text - EmptyString. Required. Text to quote\n'
base="sed.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Quote a string to be used in a sed pattern on the command line.\n\n'
descriptionLineCount="2"
example=$'    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"\n    needSlash=$(quoteSedPattern \'$.*/[\\]^\')\n'
file="bin/build/tools/sed.sh"
fn="quoteSedPattern"
fnMarker="quotesedpattern"
foundNames=([0]="summary" [1]="argument" [2]="output" [3]="example" [4]="requires")
line="38"
needSlash=""
original="quoteSedPattern"
output=$'string quoted and appropriate to insert in a sed search or replacement phrase\n'
rawComment=$'Summary: Quote sed search strings for shell use\nQuote a string to be used in a sed pattern on the command line.\nArgument: text - EmptyString. Required. Text to quote\nOutput: string quoted and appropriate to insert in a sed search or replacement phrase\nExample:     sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"\nExample:     needSlash=$(quoteSedPattern \'$.*/[\\]^\')\nRequires: printf sed bashDocumentation helpArgument\n\n'
requires=$'printf sed bashDocumentation helpArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/sed.sh"
sourceHash="f0fc6b83d684caf722f5b07d53b68ae6ac5fa68a"
sourceLine="38"
summary="Quote sed search strings for shell use"
summaryComputed=""
usage="quoteSedPattern text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mquoteSedPattern'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtext  '$'\e''[[(value)]mEmptyString. Required. Text to quote'$'\e''[[(reset)]m'$'\n'''$'\n''Quote a string to be used in a sed pattern on the command line.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"'$'\n''    needSlash=$(quoteSedPattern '\''$.'$'\e''[[(cyan)]m/[\]^'\'')'$'\e''[[(reset)]m'
# shellcheck disable=SC2016
helpPlain='Usage: quoteSedPattern text'$'\n'''$'\n''    text  EmptyString. Required. Text to quote'$'\n'''$'\n''Quote a string to be used in a sed pattern on the command line.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"'$'\n''    needSlash=$(quoteSedPattern '\''$./[\]^'\'')'
documentationPath="documentation/source/tools/quote.md"
