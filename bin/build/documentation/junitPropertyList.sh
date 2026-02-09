#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-09
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML \`property\` tags."$'\n'""
base="junit.sh"
description="Output list of \`property\` tags"$'\n'""
file="bin/build/tools/junit.sh"
foundNames=([0]="argument")
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Output list of \`property\` tags"$'\n'"Argument: nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML \`property\` tags."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="a571b497675fc8f0150b346132dcce8611ac99a3"
summary="Output list of \`property\` tags"
summaryComputed="true"
usage="junitPropertyList [ --help ] [ nameValue ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitPropertyList'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ nameValue ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mnameValue ...  '$'\e''[[(value)]mOptional. String. A list of name value pairs (unquoted) to output as XML '$'\e''[[(code)]mproperty'$'\e''[[(reset)]m tags.'$'\e''[[(reset)]m'$'\n'''$'\n''Output list of '$'\e''[[(code)]mproperty'$'\e''[[(reset)]m tags'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: junitPropertyList [ --help ] [ nameValue ... ]'$'\n'''$'\n''    --help         Flag. Optional. Display this help.'$'\n''    nameValue ...  Optional. String. A list of name value pairs (unquoted) to output as XML property tags.'$'\n'''$'\n''Output list of property tags'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
