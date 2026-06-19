#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nhandler - Function. Required. Error handler.\njsonFile - File. Required. A JSON file to parse\n... - Arguments. Optional. Passed directly to jq\n'
base="json.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Fetch a non-blank field from a JSON file with error handling\n\n'
descriptionLineCount="2"
file="bin/build/tools/json.sh"
fn="jsonField"
fnMarker="jsonfield"
foundNames=([0]="argument" [1]="stdout" [2]="stderr" [3]="return_code" [4]="requires")
line="23"
rawComment=$'Fetch a non-blank field from a JSON file with error handling\nArgument: --help - Flag. Optional. Display this help.\nArgument: handler - Function. Required. Error handler.\nArgument: jsonFile - File. Required. A JSON file to parse\nArgument: ... - Arguments. Optional. Passed directly to jq\nstdout: selected field\nstderr: error messages\nReturn Code: 0 - Field was found and was non-blank\nReturn Code: 1 - Field was not found or is blank\nRequires: jq executableExists throwEnvironment printf rm decorate head\n\n'
requires=$'jq executableExists throwEnvironment printf rm decorate head\n'
return_code=$'0 - Field was found and was non-blank\n1 - Field was not found or is blank\n'
sourceFile="bin/build/tools/json.sh"
sourceHash="2b4f94c4ddf89badcde584cda1ab28267e5078dc"
sourceLine="23"
stderr=$'error messages\n'
stdout=$'selected field\n'
summary="Fetch a non-blank field from a JSON file with error"
summaryComputed="true"
usage="jsonField [ --help ] handler jsonFile [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonField'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mjsonFile'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mhandler   '$'\e''[[(value)]mFunction. Required. Error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mjsonFile  '$'\e''[[(value)]mFile. Required. A JSON file to parse'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...       '$'\e''[[(value)]mArguments. Optional. Passed directly to jq'$'\e''[[(reset)]m'$'\n'''$'\n''Fetch a non-blank field from a JSON file with error handling'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Field was found and was non-blank'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Field was not found or is blank'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''selected field'
# shellcheck disable=SC2016
helpPlain='Usage: jsonField [ --help ] handler jsonFile [ ... ]'$'\n'''$'\n''    --help    Flag. Optional. Display this help.'$'\n''    handler   Function. Required. Error handler.'$'\n''    jsonFile  File. Required. A JSON file to parse'$'\n''    ...       Arguments. Optional. Passed directly to jq'$'\n'''$'\n''Fetch a non-blank field from a JSON file with error handling'$'\n'''$'\n''Return codes:'$'\n''- 0 - Field was found and was non-blank'$'\n''- 1 - Field was not found or is blank'$'\n'''$'\n''Writes to stdout:'$'\n''selected field'
documentationPath="documentation/source/tools/json.md"
