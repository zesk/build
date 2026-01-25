#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="jsonFile - File. Required. File to get value from."$'\n'"path - String. Required. dot-separated path to modify (e.g. \`extra.fingerprint\`)"$'\n'"value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. **Note the difference between a blank argument and NO argument.**"$'\n'""
base="json.sh"
description="Set or delete a value in a JSON file"$'\n'""
exitCode="0"
file="bin/build/tools/json.sh"
foundNames=([0]="argument")
rawComment="Set or delete a value in a JSON file"$'\n'"Argument: jsonFile - File. Required. File to get value from."$'\n'"Argument: path - String. Required. dot-separated path to modify (e.g. \`extra.fingerprint\`)"$'\n'"Argument: value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. **Note the difference between a blank argument and NO argument.**"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184734"
summary="Set or delete a value in a JSON file"
usage="jsonFileSet jsonFile path [ value ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mjsonFileSet'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mjsonFile'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mpath'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ value ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mjsonFile   '$'\e''[[value]mFile. Required. File to get value from.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mpath       '$'\e''[[value]mString. Required. dot-separated path to modify (e.g. '$'\e''[[code]mextra.fingerprint'$'\e''[[reset]m)'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mvalue ...  '$'\e''[[value]mEmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. '$'\e''[[red]mNote the difference between a blank argument and NO argument.'$'\e''[[reset]m'$'\e''[[reset]m'$'\n'''$'\n''Set or delete a value in a JSON file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: jsonFileSet jsonFile path [ value ... ]'$'\n'''$'\n''    jsonFile   File. Required. File to get value from.'$'\n''    path       String. Required. dot-separated path to modify (e.g. extra.fingerprint)'$'\n''    value ...  EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. Note the difference between a blank argument and NO argument.'$'\n'''$'\n''Set or delete a value in a JSON file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
