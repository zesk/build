#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="json.sh"
description="Get a value in a JSON file"$'\n'"Argument: jsonFile - File. Required. File to get value from."$'\n'"Argument: path - String. Required. dot-separated path to get"$'\n'""
file="bin/build/tools/json.sh"
foundNames=()
rawComment="Get a value in a JSON file"$'\n'"Argument: jsonFile - File. Required. File to get value from."$'\n'"Argument: path - String. Required. dot-separated path to get"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="04f705674d59cb28ade42446bb95f975d543df42"
summary="Get a value in a JSON file"
usage="jsonFileGet"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonFileGet'$'\e''[0m'$'\n'''$'\n''Get a value in a JSON file'$'\n''Argument: jsonFile - File. Required. File to get value from.'$'\n''Argument: path - String. Required. dot-separated path to get'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: jsonFileGet'$'\n'''$'\n''Get a value in a JSON file'$'\n''Argument: jsonFile - File. Required. File to get value from.'$'\n''Argument: path - String. Required. dot-separated path to get'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.487
