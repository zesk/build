#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="json.sh"
description="Set or delete a value in a JSON file"$'\n'"Argument: jsonFile - File. Required. File to get value from."$'\n'"Argument: path - String. Required. dot-separated path to modify (e.g. \`extra.fingerprint\`)"$'\n'"Argument: value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. **Note the difference between a blank argument and NO argument.**"$'\n'""
file="bin/build/tools/json.sh"
foundNames=()
rawComment="Set or delete a value in a JSON file"$'\n'"Argument: jsonFile - File. Required. File to get value from."$'\n'"Argument: path - String. Required. dot-separated path to modify (e.g. \`extra.fingerprint\`)"$'\n'"Argument: value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. **Note the difference between a blank argument and NO argument.**"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="04f705674d59cb28ade42446bb95f975d543df42"
summary="Set or delete a value in a JSON file"
usage="jsonFileSet"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjsonFileSet'$'\e''[0m'$'\n'''$'\n''Set or delete a value in a JSON file'$'\n''Argument: jsonFile - File. Required. File to get value from.'$'\n''Argument: path - String. Required. dot-separated path to modify (e.g. '$'\e''[[(code)]mextra.fingerprint'$'\e''[[(reset)]m)'$'\n''Argument: value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. '$'\e''[[(red)]mNote the difference between a blank argument and NO argument.'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: jsonFileSet'$'\n'''$'\n''Set or delete a value in a JSON file'$'\n''Argument: jsonFile - File. Required. File to get value from.'$'\n''Argument: path - String. Required. dot-separated path to modify (e.g. extra.fingerprint)'$'\n''Argument: value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. Note the difference between a blank argument and NO argument.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.494
