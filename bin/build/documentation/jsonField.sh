#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"handler - Function. Required. Error handler."$'\n'"jsonFile - File. Required. A JSON file to parse"$'\n'"... - Arguments. Optional. Passed directly to jq"$'\n'""
base="json.sh"
description="Fetch a non-blank field from a JSON file with error handling"$'\n'"Return Code: 0 - Field was found and was non-blank"$'\n'"Return Code: 1 - Field was not found or is blank"$'\n'""
file="bin/build/tools/json.sh"
fn="jsonField"
foundNames=([0]="argument" [1]="stdout" [2]="stderr" [3]="requires")
requires="jq whichExists throwEnvironment printf rm decorate head"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/json.sh"
sourceModified="1768721469"
stderr="error messages"$'\n'""
stdout="selected field"$'\n'""
summary="Fetch a non-blank field from a JSON file with error"
usage="jsonField [ --help ] handler jsonFile [ ... ]"
