#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="jsonFile - File. Required. File to get value from."$'\n'"path - String. Required. dot-separated path to modify (e.g. \`extra.fingerprint\`)"$'\n'"value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. **Note the difference between a blank argument and NO argument.**"$'\n'""
base="json.sh"
description="Set or delete a value in a JSON file"$'\n'""
file="bin/build/tools/json.sh"
fn="jsonFileSet"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceModified="1768721469"
summary="Set or delete a value in a JSON file"
usage="jsonFileSet jsonFile path [ value ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mjsonFileSet[0m [38;2;255;255;0m[35;48;2;0;0;0mjsonFile[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mpath[0m[0m [94m[ value ... ][0m

    [31mjsonFile   [1;97mFile. Required. File to get value from.[0m
    [31mpath       [1;97mString. Required. dot-separated path to modify (e.g. [38;2;0;255;0;48;2;0;0;0mextra.fingerprint[0m)[0m
    [94mvalue ...  [1;97mEmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. [31mNote the difference between a blank argument and NO argument.[0m[0m

Set or delete a value in a JSON file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: jsonFileSet jsonFile path [ value ... ]

    jsonFile   File. Required. File to get value from.
    path       String. Required. dot-separated path to modify (e.g. extra.fingerprint)
    value ...  EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. Note the difference between a blank argument and NO argument.

Set or delete a value in a JSON file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
