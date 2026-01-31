#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="json.sh"
description="Fetch a non-blank field from a JSON file with error handling"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: handler - Function. Required. Error handler."$'\n'"Argument: jsonFile - File. Required. A JSON file to parse"$'\n'"Argument: ... - Arguments. Optional. Passed directly to jq"$'\n'"stdout: selected field"$'\n'"stderr: error messages"$'\n'"Return Code: 0 - Field was found and was non-blank"$'\n'"Return Code: 1 - Field was not found or is blank"$'\n'"Requires: jq executableExists throwEnvironment printf rm decorate head"$'\n'""
file="bin/build/tools/json.sh"
foundNames=()
rawComment="Fetch a non-blank field from a JSON file with error handling"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: handler - Function. Required. Error handler."$'\n'"Argument: jsonFile - File. Required. A JSON file to parse"$'\n'"Argument: ... - Arguments. Optional. Passed directly to jq"$'\n'"stdout: selected field"$'\n'"stderr: error messages"$'\n'"Return Code: 0 - Field was found and was non-blank"$'\n'"Return Code: 1 - Field was not found or is blank"$'\n'"Requires: jq executableExists throwEnvironment printf rm decorate head"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="04f705674d59cb28ade42446bb95f975d543df42"
summary="Fetch a non-blank field from a JSON file with error"
usage="jsonField"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonField'$'\e''[0m'$'\n'''$'\n''Fetch a non-blank field from a JSON file with error handling'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: handler - Function. Required. Error handler.'$'\n''Argument: jsonFile - File. Required. A JSON file to parse'$'\n''Argument: ... - Arguments. Optional. Passed directly to jq'$'\n''stdout: selected field'$'\n''stderr: error messages'$'\n''Return Code: 0 - Field was found and was non-blank'$'\n''Return Code: 1 - Field was not found or is blank'$'\n''Requires: jq executableExists throwEnvironment printf rm decorate head'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: jsonField'$'\n'''$'\n''Fetch a non-blank field from a JSON file with error handling'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: handler - Function. Required. Error handler.'$'\n''Argument: jsonFile - File. Required. A JSON file to parse'$'\n''Argument: ... - Arguments. Optional. Passed directly to jq'$'\n''stdout: selected field'$'\n''stderr: error messages'$'\n''Return Code: 0 - Field was found and was non-blank'$'\n''Return Code: 1 - Field was not found or is blank'$'\n''Requires: jq executableExists throwEnvironment printf rm decorate head'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.468
