#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"handler - Function. Required. Error handler."$'\n'"jsonFile - File. Required. A JSON file to parse"$'\n'"... - Arguments. Optional. Passed directly to jq"$'\n'""
base="json.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fetch a non-blank field from a JSON file with error handling"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/json.sh"
fn="jsonField"
fnMarker="jsonfield"
foundNames=([0]="argument" [1]="stdout" [2]="stderr" [3]="return_code" [4]="requires")
line="23"
rawComment="Fetch a non-blank field from a JSON file with error handling"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: handler - Function. Required. Error handler."$'\n'"Argument: jsonFile - File. Required. A JSON file to parse"$'\n'"Argument: ... - Arguments. Optional. Passed directly to jq"$'\n'"stdout: selected field"$'\n'"stderr: error messages"$'\n'"Return Code: 0 - Field was found and was non-blank"$'\n'"Return Code: 1 - Field was not found or is blank"$'\n'"Requires: jq executableExists throwEnvironment printf rm decorate head"$'\n'""$'\n'""
requires="jq executableExists throwEnvironment printf rm decorate head"$'\n'""
return_code="0 - Field was found and was non-blank"$'\n'"1 - Field was not found or is blank"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="e4fa7a237368db1e6a6969ecf3a1c6f05241d727"
sourceLine="23"
stderr="error messages"$'\n'""
stdout="selected field"$'\n'""
summary="Fetch a non-blank field from a JSON file with error"
summaryComputed="true"
usage="jsonField [ --help ] handler jsonFile [ ... ]"
