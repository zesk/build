#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"handler - Function. Required. Error handler."$'\n'"jsonFile - File. Required. A JSON file to parse"$'\n'"... - Arguments. Optional. Passed directly to jq"$'\n'""
base="json.sh"
description="Fetch a non-blank field from a JSON file with error handling"$'\n'""
exitCode="0"
file="bin/build/tools/json.sh"
foundNames=([0]="argument" [1]="stdout" [2]="stderr" [3]="return_code" [4]="requires")
rawComment="Fetch a non-blank field from a JSON file with error handling"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: handler - Function. Required. Error handler."$'\n'"Argument: jsonFile - File. Required. A JSON file to parse"$'\n'"Argument: ... - Arguments. Optional. Passed directly to jq"$'\n'"stdout: selected field"$'\n'"stderr: error messages"$'\n'"Return Code: 0 - Field was found and was non-blank"$'\n'"Return Code: 1 - Field was not found or is blank"$'\n'"Requires: jq executableExists throwEnvironment printf rm decorate head"$'\n'""$'\n'""
requires="jq executableExists throwEnvironment printf rm decorate head"$'\n'""
return_code="0 - Field was found and was non-blank"$'\n'"1 - Field was not found or is blank"$'\n'""
sourceModified="1769184734"
stderr="error messages"$'\n'""
stdout="selected field"$'\n'""
summary="Fetch a non-blank field from a JSON file with error"
usage="jsonField [ --help ] handler jsonFile [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mjsonField'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mjsonFile'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help    '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mhandler   '$'\e''[[value]mFunction. Required. Error handler.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mjsonFile  '$'\e''[[value]mFile. Required. A JSON file to parse'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m...       '$'\e''[[value]mArguments. Optional. Passed directly to jq'$'\e''[[reset]m'$'\n'''$'\n''Fetch a non-blank field from a JSON file with error handling'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Field was found and was non-blank'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Field was not found or is blank'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''selected field'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: jsonField [ --help ] handler jsonFile [ ... ]'$'\n'''$'\n''    --help    Flag. Optional. Display this help.'$'\n''    handler   Function. Required. Error handler.'$'\n''    jsonFile  File. Required. A JSON file to parse'$'\n''    ...       Arguments. Optional. Passed directly to jq'$'\n'''$'\n''Fetch a non-blank field from a JSON file with error handling'$'\n'''$'\n''Return codes:'$'\n''- 0 - Field was found and was non-blank'$'\n''- 1 - Field was not found or is blank'$'\n'''$'\n''Writes to stdout:'$'\n''selected field'$'\n'''
