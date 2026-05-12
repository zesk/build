#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nsource - File. Required. File where documentation exists.\nfunction - String. Required. Function to document.\nreturnCode - UnsignedInteger. Required. Exit code to return.\nmessage ... - String. Optional. Message to display to the user.\n'
base="usage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output a simple error message for a function.\n\n'
descriptionLineCount="2"
file="bin/build/tools/usage.sh"
fn="bashSimpleDocumentation"
fnMarker="bashsimpledocumentation"
foundNames=([0]="summary" [1]="argument" [2]="requires")
line="198"
rawComment=$'Summary: Simpler `bashDocumentation`\nOutput a simple error message for a function.\nArgument: --help - Flag. Optional. Display this help.\nArgument: source - File. Required. File where documentation exists.\nArgument: function - String. Required. Function to document.\nArgument: returnCode - UnsignedInteger. Required. Exit code to return.\nArgument: message ... - String. Optional. Message to display to the user.\nRequires: bashFunctionComment decorate read printf returnCodeString helpArgument bashDocumentation __bashDocumentationCached\n\n'
requires=$'bashFunctionComment decorate read printf returnCodeString helpArgument bashDocumentation __bashDocumentationCached\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/usage.sh"
sourceHash="3291d7e64ccb36a84b9d6875ccfaa2cae11670fd"
sourceLine="198"
summary="Simpler \`bashDocumentation\`"
summaryComputed=""
usage="bashSimpleDocumentation [ --help ] source function returnCode [ message ... ]"
