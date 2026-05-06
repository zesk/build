#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="usage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output documentation for a function in Markdown format"
descriptionLineCount=""
file="bin/build/tools/usage.sh"
fn="bashDocumentationMarkdown"
fnMarker="bashdocumentationmarkdown"
foundNames=([0]="summary" [1]="argument")
line="24"
rawComment="Summary: Output documentation for a function in Markdown format"$'\n'"Argument: functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="d422aa5ba72eb3aa919a918c054e1c085f507523"
sourceLine="24"
summary="Output documentation for a function in Markdown format"
summaryComputed=""
usage="bashDocumentationMarkdown functionName [ --help ]"
