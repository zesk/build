#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'path - String. Output a json path separated by dots.\n'
base="json.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate a path for a JSON structure for use in `jq` queries\n\nWithout arguments, displays help.\n\n'
descriptionLineCount="4"
file="bin/build/tools/json.sh"
fn="jsonPath"
fnMarker="jsonpath"
foundNames=([0]="summary" [1]="argument")
line="48"
rawComment=$'Summary: Generate `jq` paths\nGenerate a path for a JSON structure for use in `jq` queries\nArgument: path - String. Output a json path separated by dots.\nWithout arguments, displays help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/json.sh"
sourceHash="2b4f94c4ddf89badcde584cda1ab28267e5078dc"
sourceLine="48"
summary="Generate \`jq\` paths"
summaryComputed=""
usage="jsonPath [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonPath'$'\e''[0m '$'\e''[[(blue)]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpath  '$'\e''[[(value)]mString. Output a json path separated by dots.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate a path for a JSON structure for use in '$'\e''[[(code)]mjq'$'\e''[[(reset)]m queries'$'\n'''$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: jsonPath [ path ]'$'\n'''$'\n''    path  String. Output a json path separated by dots.'$'\n'''$'\n''Generate a path for a JSON structure for use in jq queries'$'\n'''$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/json.md"
