#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-19
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"source - File. Required. File where documentation exists."$'\n'"function - String. Required. Function to document."$'\n'"returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"message ... - String. Optional. Message to display to the user."$'\n'""
base="usage.sh"
description="Output a simple error message for a function"$'\n'""
file="bin/build/tools/usage.sh"
fn="usageDocumentSimple"
foundNames=([0]="argument" [1]="requires")
rawComment="Output a simple error message for a function"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: source - File. Required. File where documentation exists."$'\n'"Argument: function - String. Required. Function to document."$'\n'"Argument: returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"Argument: message ... - String. Optional. Message to display to the user."$'\n'"Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached"$'\n'""$'\n'""
requires="bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="f65c518b4a4ff4ec7b99d94559eebf9d5483b88d"
summary="Output a simple error message for a function"
summaryComputed="true"
usage="usageDocumentSimple [ --help ] source function returnCode [ message ... ]"
