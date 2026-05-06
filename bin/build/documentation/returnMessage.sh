#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="exitCode - UnsignedInteger. Required. Exit code to return. Default is 1."$'\n'"message ... - String. Optional. Message to output"$'\n'""
base="example.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Return passed in integer return code and output message to \`stderr\` (non-zero) or \`stdout\` (zero)"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/example.sh"
fn="returnMessage"
fnMarker="returnmessage"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="143"
rawComment="Return passed in integer return code and output message to \`stderr\` (non-zero) or \`stdout\` (zero)"$'\n'"Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1."$'\n'"Argument: message ... - String. Optional. Message to output"$'\n'"Return Code: exitCode"$'\n'"Requires: isUnsignedInteger printf returnMessage"$'\n'""$'\n'""
requires="isUnsignedInteger printf returnMessage"$'\n'""
return_code="exitCode"$'\n'""
sourceFile="bin/build/tools/example.sh"
sourceHash="820d8370bcdbfb0ad79b81b486dcb0ce06dd8a19"
sourceLine="143"
summary="Return passed in integer return code and output message to"
summaryComputed="true"
usage="returnMessage exitCode [ message ... ]"
