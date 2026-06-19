#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'value - Integer. Required.\nformat - String. Required.\nisUTC - Boolean. Optional. Defaults to `true`.\n'
base="Darwin.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Platform-specific implementation of `dateFromTimestamp`.\n\n'
descriptionLineCount="2"
file="bin/build/tools/platform/Darwin.sh"
fn="__dateFromTimestamp"
fnMarker="__datefromtimestamp"
foundNames=([0]="requires" [1]="summary" [2]="argument")
line="39"
rawComment=$'Requires: date\nSummary: Platform `dateFromTimestamp`\nPlatform-specific implementation of `dateFromTimestamp`.\nArgument: value - Integer. Required.\nArgument: format - String. Required.\nArgument: isUTC - Boolean. Optional. Defaults to `true`.\n\n'
requires=$'date\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/platform/Darwin.sh"
sourceHash="1bce34340d0a4bbeedbd5d17b05eded12ac33465"
sourceLine="39"
summary="Platform \`dateFromTimestamp\`"
summaryComputed=""
usage="__dateFromTimestamp value format [ isUTC ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__dateFromTimestamp'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvalue'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mformat'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ isUTC ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvalue   '$'\e''[[(value)]mInteger. Required.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mformat  '$'\e''[[(value)]mString. Required.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]misUTC   '$'\e''[[(value)]mBoolean. Optional. Defaults to '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Platform-specific implementation of '$'\e''[[(code)]mdateFromTimestamp'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __dateFromTimestamp value format [ isUTC ]'$'\n'''$'\n''    value   Integer. Required.'$'\n''    format  String. Required.'$'\n''    isUTC   Boolean. Optional. Defaults to true.'$'\n'''$'\n''Platform-specific implementation of dateFromTimestamp.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/internal.md"
