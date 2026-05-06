#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="jsonFile - File. Required. File to get value from."$'\n'"path - String. Required. dot-separated path to get"$'\n'""
base="json.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get a value in a JSON file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/json.sh"
fn="jsonFileGet"
fnMarker="jsonfileget"
foundNames=([0]="argument")
line="88"
rawComment="Get a value in a JSON file"$'\n'"Argument: jsonFile - File. Required. File to get value from."$'\n'"Argument: path - String. Required. dot-separated path to get"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="e4fa7a237368db1e6a6969ecf3a1c6f05241d727"
sourceLine="88"
summary="Get a value in a JSON file"
summaryComputed="true"
usage="jsonFileGet jsonFile path"
