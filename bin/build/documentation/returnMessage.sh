#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools.sh"
argument="exitCode -  UnsignedInteger. Required. Exit code to return. Default is 1."$'\n'"message ... - String. Optional. Message to output"$'\n'""
base="tools.sh"
description="Return passed in integer return code and output message to \`stderr\` (non-zero) or \`stdout\` (zero)"$'\n'"Return Code: exitCode"$'\n'""
file="bin/build/tools.sh"
fn="returnMessage"
foundNames=([0]="argument" [1]="requires")
requires="isUnsignedInteger printf returnMessage"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools.sh"
sourceModified="1768683853"
summary="Return passed in integer return code and output message to"
usage="returnMessage exitCode [ message ... ]"
