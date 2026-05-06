#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="indexFile ... - File. Required. One or more index files to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="markdown.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Displays any markdown files next to the given index file which are not found within the index file as links."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/markdown.sh"
fn="markdownCheckIndex"
fnMarker="markdowncheckindex"
foundNames=([0]="argument")
line="143"
rawComment="Argument: indexFile ... - File. Required. One or more index files to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Displays any markdown files next to the given index file which are not found within the index file as links."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/markdown.sh"
sourceHash="b0c6db65fd4dec5df3f8a36220ec0140b58ea621"
sourceLine="143"
summary="Displays any markdown files next to the given index file"
summaryComputed="true"
usage="markdownCheckIndex indexFile ... [ --help ] [ --handler handler ]"
