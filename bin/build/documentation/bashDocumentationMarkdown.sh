#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="usage.sh"
description="Output documentation for a function in Markdown format"$'\n'""
file="bin/build/tools/usage.sh"
fn="bashDocumentationMarkdown"
foundNames=([0]="summary" [1]="argument")
line="24"
lowerFn="bashdocumentationmarkdown"
rawComment="Summary: Output documentation for a function in Markdown format"$'\n'"Argument: functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="f78944fb6a094a23e87df1b578764a61fd0bee9e"
sourceLine="24"
summary="Output documentation for a function in Markdown format"$'\n'""
usage="bashDocumentationMarkdown functionName [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDocumentationMarkdown'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfunctionName  '$'\e''[[(value)]mString. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output documentation for a function in Markdown format'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashDocumentationMarkdown functionName [ --help ]'$'\n'''$'\n''    functionName  String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Output documentation for a function in Markdown format'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/usage.md"
