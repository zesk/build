#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-03
# shellcheck disable=SC2034
argument=$'suffix - String. Optional. Directory suffix - created if does not exist.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the default cache directory for the documentation\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationCache"
fnMarker="documentationcache"
foundNames=([0]="argument")
line="211"
rawComment=$'Get the default cache directory for the documentation\nArgument: suffix - String. Optional. Directory suffix - created if does not exist.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="a3794434b7e4d336ccd6c9cbf964150d59b552f0"
sourceLine="211"
summary="Get the default cache directory for the documentation"
summaryComputed="true"
usage="documentationCache [ suffix ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationCache'$'\e''[0m '$'\e''[[(blue)]m[ suffix ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]msuffix  '$'\e''[[(value)]mString. Optional. Directory suffix - created if does not exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the default cache directory for the documentation'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationCache [ suffix ] [ --help ]'$'\n'''$'\n''    suffix  String. Optional. Directory suffix - created if does not exist.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the default cache directory for the documentation'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
