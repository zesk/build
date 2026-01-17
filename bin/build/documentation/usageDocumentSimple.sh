#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"source - File. Required. File where documentation exists."$'\n'"function - String. Required. Function to document."$'\n'"returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"message ... - String. Optional. Message to display to the user."$'\n'""
base="usage.sh"
description="Output a simple error message for a function"$'\n'""
file="bin/build/tools/usage.sh"
fn="usageDocumentSimple"
foundNames=([0]="argument" [1]="requires")
requires="bashFunctionComment decorate read printf returnCodeString __help usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/usage.sh"
sourceModified="1768683999"
summary="Output a simple error message for a function"
usage="usageDocumentSimple [ --help ] source function returnCode [ message ... ]"
