#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'handler - Function. Required.\nhome - Directory. `BUILD_HOME`\nfunctionName - String. Function to display usage for\nreturnCode - UnsignedInteger. Optional. Exit code to display. Defaults to `0` - no error.\nmessage ... - String. Optional. Display this message which describes why `exitCode` occurred.\n'
base="usage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Display cached usage for a function"
descriptionLineCount=""
environment=$'BUILD_HOME BUILD_COLORS BUILD_DOCUMENTATION_PATH\n'
file="bin/build/tools/usage.sh"
fn="__bashDocumentationCached"
fnMarker="__bashdocumentationcached"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="requires")
line="167"
rawComment=$'Summary: Display cached usage for a function\nArgument: handler - Function. Required.\nArgument: home - Directory. `BUILD_HOME`\nArgument: functionName - String. Function to display usage for\nArgument: returnCode - UnsignedInteger. Optional. Exit code to display. Defaults to `0` - no error.\nArgument: message ... - String. Optional. Display this message which describes why `exitCode` occurred.\nEnvironment: BUILD_HOME BUILD_COLORS BUILD_DOCUMENTATION_PATH\nRequires: decorateThemed catchEnvironment __usageMessage decorate __functionSettings\n\n'
requires=$'decorateThemed catchEnvironment __usageMessage decorate __functionSettings\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/usage.sh"
sourceHash="a0d97ecc9813706b3f622c5e5d72cf6b76630152"
sourceLine="167"
summary="Display cached usage for a function"
summaryComputed=""
usage="__bashDocumentationCached handler [ home ] [ functionName ] [ returnCode ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__bashDocumentationCached'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ home ]'$'\e''[0m '$'\e''[[(blue)]m[ functionName ]'$'\e''[0m '$'\e''[[(blue)]m[ returnCode ]'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhandler       '$'\e''[[(value)]mFunction. Required.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mhome          '$'\e''[[(value)]mDirectory. '$'\e''[[(code)]mBUILD_HOME'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfunctionName  '$'\e''[[(value)]mString. Function to display usage for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mreturnCode    '$'\e''[[(value)]mUnsignedInteger. Optional. Exit code to display. Defaults to '$'\e''[[(code)]m0'$'\e''[[(reset)]m - no error.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...   '$'\e''[[(value)]mString. Optional. Display this message which describes why '$'\e''[[(code)]mexitCode'$'\e''[[(reset)]m occurred.'$'\e''[[(reset)]m'$'\n'''$'\n''Display cached usage for a function'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOME BUILD_COLORS BUILD_DOCUMENTATION_PATH'
# shellcheck disable=SC2016
helpPlain='Usage: __bashDocumentationCached handler [ home ] [ functionName ] [ returnCode ] [ message ... ]'$'\n'''$'\n''    handler       Function. Required.'$'\n''    home          Directory. BUILD_HOME'$'\n''    functionName  String. Function to display usage for'$'\n''    returnCode    UnsignedInteger. Optional. Exit code to display. Defaults to 0 - no error.'$'\n''    message ...   String. Optional. Display this message which describes why exitCode occurred.'$'\n'''$'\n''Display cached usage for a function'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOME BUILD_COLORS BUILD_DOCUMENTATION_PATH'
documentationPath="documentation/source/tools/usage.md"
