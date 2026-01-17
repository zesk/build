#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="jsonFile - File. Required. File to get value from."$'\n'"path - String. Required. dot-separated path to modify (e.g. \`extra.fingerprint\`)"$'\n'"value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. **Note the difference between a blank argument and NO argument.**"$'\n'""
base="json.sh"
description="Set or delete a value in a JSON file"$'\n'""
file="bin/build/tools/json.sh"
fn="jsonFileSet"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/json.sh"
sourceModified="1768683751"
summary="Set or delete a value in a JSON file"
usage="jsonFileSet jsonFile path [ value ... ]"
