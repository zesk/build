#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"source - File. Required. File where documentation exists."$'\n'"function - String. Required. Function to document."$'\n'"returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"message ... - String. Optional. Message to display to the user."$'\n'""
base="usage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output a simple error message for a function."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/usage.sh"
fn="bashSimpleDocumentation"
fnMarker="bashsimpledocumentation"
foundNames=([0]="summary" [1]="argument" [2]="requires")
line="198"
rawComment="Summary: Simpler \`bashDocumentation\`"$'\n'"Output a simple error message for a function."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: source - File. Required. File where documentation exists."$'\n'"Argument: function - String. Required. Function to document."$'\n'"Argument: returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"Argument: message ... - String. Optional. Message to display to the user."$'\n'"Requires: bashFunctionComment decorate read printf returnCodeString helpArgument bashDocumentation __bashDocumentationCached"$'\n'""$'\n'""
requires="bashFunctionComment decorate read printf returnCodeString helpArgument bashDocumentation __bashDocumentationCached"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="d422aa5ba72eb3aa919a918c054e1c085f507523"
sourceLine="198"
summary="Simpler \`bashDocumentation\`"
summaryComputed=""
usage="bashSimpleDocumentation [ --help ] source function returnCode [ message ... ]"
