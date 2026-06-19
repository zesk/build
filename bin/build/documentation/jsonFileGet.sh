#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'jsonFile - File. Required. File to get value from.\npath - String. Required. dot-separated path to get\n'
base="json.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get a value in a JSON file\n\n'
descriptionLineCount="2"
file="bin/build/tools/json.sh"
fn="jsonFileGet"
fnMarker="jsonfileget"
foundNames=([0]="argument")
line="88"
rawComment=$'Get a value in a JSON file\nArgument: jsonFile - File. Required. File to get value from.\nArgument: path - String. Required. dot-separated path to get\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/json.sh"
sourceHash="2b4f94c4ddf89badcde584cda1ab28267e5078dc"
sourceLine="88"
summary="Get a value in a JSON file"
summaryComputed="true"
usage="jsonFileGet jsonFile path"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonFileGet'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mjsonFile'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mjsonFile  '$'\e''[[(value)]mFile. Required. File to get value from.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpath      '$'\e''[[(value)]mString. Required. dot-separated path to get'$'\e''[[(reset)]m'$'\n'''$'\n''Get a value in a JSON file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: jsonFileGet jsonFile path'$'\n'''$'\n''    jsonFile  File. Required. File to get value from.'$'\n''    path      String. Required. dot-separated path to get'$'\n'''$'\n''Get a value in a JSON file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/json.md"
