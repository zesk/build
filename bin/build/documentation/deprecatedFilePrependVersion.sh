#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="target - File. Required. File to update."$'\n'"version - String. Required. Version to place at the top of the file."$'\n'""
base="deprecated-tools.sh"
description="Take a deprecated.txt file and add a comment with the current version number to the top"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedFilePrependVersion"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deprecated-tools.sh"
sourceModified="1768683751"
summary="Take a deprecated.txt file and add a comment with the"
usage="deprecatedFilePrependVersion target version"
