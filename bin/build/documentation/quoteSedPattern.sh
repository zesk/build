#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sed.sh"
argument="text - EmptyString. Required. Text to quote"$'\n'""
base="sed.sh"
description="Quote a string to be used in a sed pattern on the command line."$'\n'""
example="    sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedPattern \"\$2\")/g\""$'\n'"    needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'""
file="bin/build/tools/sed.sh"
foundNames=([0]="summary" [1]="argument" [2]="output" [3]="example" [4]="requires")
needSlash=""
output="string quoted and appropriate to insert in a sed search or replacement phrase"$'\n'""
rawComment="Summary: Quote sed search strings for shell use"$'\n'"Quote a string to be used in a sed pattern on the command line."$'\n'"Argument: text - EmptyString. Required. Text to quote"$'\n'"Output: string quoted and appropriate to insert in a sed search or replacement phrase"$'\n'"Example:     sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedPattern \"\$2\")/g\""$'\n'"Example:     needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'"Requires: printf sed usageDocument __help"$'\n'""$'\n'""
requires="printf sed usageDocument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sed.sh"
sourceModified="1769063211"
summary="Quote sed search strings for shell use"$'\n'""
usage="quoteSedPattern text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mquoteSedPattern'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtext  '$'\e''[[(value)]mEmptyString. Required. Text to quote'$'\e''[[(reset)]m'$'\n'''$'\n''Quote a string to be used in a sed pattern on the command line.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"'$'\n''    needSlash=$(quoteSedPattern '\''$.'$'\e''[[(cyan)]m/[\]^'\'')'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: quoteSedPattern text'$'\n'''$'\n''    text  EmptyString. Required. Text to quote'$'\n'''$'\n''Quote a string to be used in a sed pattern on the command line.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"'$'\n''    needSlash=$(quoteSedPattern '\''$./[\]^'\'')'$'\n'''
# elapsed 0.441
