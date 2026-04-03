#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="jsonFile - File. Required. File to get value from."$'\n'"path - String. Required. dot-separated path to get"$'\n'""
base="json.sh"
description="Get a value in a JSON file"$'\n'""
file="bin/build/tools/json.sh"
fn="jsonFileGet"
foundNames=([0]="argument")
rawComment="Get a value in a JSON file"$'\n'"Argument: jsonFile - File. Required. File to get value from."$'\n'"Argument: path - String. Required. dot-separated path to get"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="e7e9bbb5a5c883cd136dbe34ac5ccb4394f94a5f"
summary="Get a value in a JSON file"
summaryComputed="true"
usage="jsonFileGet jsonFile path"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonFileGet'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mjsonFile'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mjsonFile  '$'\e''[[(value)]mFile. Required. File to get value from.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpath      '$'\e''[[(value)]mString. Required. dot-separated path to get'$'\e''[[(reset)]m'$'\n'''$'\n''Get a value in a JSON file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: jsonFileGet jsonFile path'$'\n'''$'\n''    jsonFile  File. Required. File to get value from.'$'\n''    path      String. Required. dot-separated path to get'$'\n'''$'\n''Get a value in a JSON file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
