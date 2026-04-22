#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="jsonFile - File. Required. File to get value from."$'\n'"path - String. Required. dot-separated path to get"$'\n'""
base="json.sh"
description="Get a value in a JSON file"$'\n'""
file="bin/build/tools/json.sh"
fn="jsonFileGet"
foundNames=([0]="argument")
line="88"
lowerFn="jsonfileget"
rawComment="Get a value in a JSON file"$'\n'"Argument: jsonFile - File. Required. File to get value from."$'\n'"Argument: path - String. Required. dot-separated path to get"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="e4fa7a237368db1e6a6969ecf3a1c6f05241d727"
sourceLine="88"
summary="Get a value in a JSON file"
summaryComputed="true"
usage="jsonFileGet jsonFile path"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonFileGet'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mjsonFile'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mjsonFile  '$'\e''[[(value)]mFile. Required. File to get value from.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpath      '$'\e''[[(value)]mString. Required. dot-separated path to get'$'\e''[[(reset)]m'$'\n'''$'\n''Get a value in a JSON file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: jsonFileGet jsonFile path'$'\n'''$'\n''    jsonFile  File. Required. File to get value from.'$'\n''    path      String. Required. dot-separated path to get'$'\n'''$'\n''Get a value in a JSON file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/json.md"
