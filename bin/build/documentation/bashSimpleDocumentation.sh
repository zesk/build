#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
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
sourceHash="a0d97ecc9813706b3f622c5e5d72cf6b76630152"
sourceLine="198"
summary="Simpler \`bashDocumentation\`"
summaryComputed=""
usage="bashSimpleDocumentation [ --help ] source function returnCode [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashSimpleDocumentation'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunction'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mreturnCode'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msource       '$'\e''[[(value)]mFile. Required. File where documentation exists.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfunction     '$'\e''[[(value)]mString. Required. Function to document.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mreturnCode   '$'\e''[[(value)]mUnsignedInteger. Required. Exit code to return.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Message to display to the user.'$'\e''[[(reset)]m'$'\n'''$'\n''Output a simple error message for a function.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashSimpleDocumentation [ --help ] source function returnCode [ message ... ]'$'\n'''$'\n''    --help       Flag. Optional. Display this help.'$'\n''    source       File. Required. File where documentation exists.'$'\n''    function     String. Required. Function to document.'$'\n''    returnCode   UnsignedInteger. Required. Exit code to return.'$'\n''    message ...  String. Optional. Message to display to the user.'$'\n'''$'\n''Output a simple error message for a function.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/usage.md"
