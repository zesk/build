#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'date - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)\n--help - Flag. Optional. Display this help.\n'
base="date.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Converts a date to an integer timestamp\n\n'
descriptionLineCount="2"
environment=$'Compatible with BSD and GNU date.\n'
example=$'    timestamp=$(dateToTimestamp \'2023-10-15\')\n'
file="bin/build/tools/date.sh"
fn="dateToTimestamp"
fnMarker="datetotimestamp"
foundNames=([0]="argument" [1]="environment" [2]="return_code" [3]="example")
line="51"
rawComment=$'Converts a date to an integer timestamp\nArgument: date - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)\nArgument: --help - Flag. Optional. Display this help.\nEnvironment: Compatible with BSD and GNU date.\nReturn Code: 1 - if parsing fails\nReturn Code: 0 - if parsing succeeds\nExample:     timestamp=$(dateToTimestamp \'2023-10-15\')\n\n'
return_code=$'1 - if parsing fails\n0 - if parsing succeeds\n'
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="51"
summary="Converts a date to an integer timestamp"
summaryComputed="true"
timestamp=""
usage="dateToTimestamp [ date ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateToTimestamp'$'\e''[0m '$'\e''[[(blue)]m[ date ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mdate    '$'\e''[[(value)]mString in the form '$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m (e.g. '$'\e''[[(code)]m2023-10-15'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Converts a date to an integer timestamp'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if parsing fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if parsing succeeds'$'\n'''$'\n''Environment variables:'$'\n''- Compatible with BSD and GNU date.'$'\n'''$'\n''Example:'$'\n''    timestamp=$(dateToTimestamp '\''2023-10-15'\'')'
# shellcheck disable=SC2016
helpPlain='Usage: dateToTimestamp [ date ] [ --help ]'$'\n'''$'\n''    date    String in the form YYYY-MM-DD (e.g. 2023-10-15)'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Converts a date to an integer timestamp'$'\n'''$'\n''Return codes:'$'\n''- 1 - if parsing fails'$'\n''- 0 - if parsing succeeds'$'\n'''$'\n''Environment variables:'$'\n''- Compatible with BSD and GNU date.'$'\n'''$'\n''Example:'$'\n''    timestamp=$(dateToTimestamp '\''2023-10-15'\'')'
documentationPath="documentation/source/tools/date.md"
