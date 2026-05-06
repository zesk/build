#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="jsonFile - File. Required. File to get value from."$'\n'"path - String. Required. dot-separated path to modify (e.g. \`extra.fingerprint\`)"$'\n'"value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. **Note the difference between a blank argument and NO argument.**"$'\n'""
base="json.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set or delete a value in a JSON file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/json.sh"
fn="jsonFileSet"
fnMarker="jsonfileset"
foundNames=([0]="argument")
line="110"
rawComment="Set or delete a value in a JSON file"$'\n'"Argument: jsonFile - File. Required. File to get value from."$'\n'"Argument: path - String. Required. dot-separated path to modify (e.g. \`extra.fingerprint\`)"$'\n'"Argument: value ... - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. **Note the difference between a blank argument and NO argument.**"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="e4fa7a237368db1e6a6969ecf3a1c6f05241d727"
sourceLine="110"
summary="Set or delete a value in a JSON file"
summaryComputed="true"
usage="jsonFileSet jsonFile path [ value ... ]"
