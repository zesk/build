#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="startLine - Integer. Required. Starting line number."$'\n'"endLine - Integer. Required. Ending line number."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Extract a range of lines from a file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="fileExtractLines"
fnMarker="fileextractlines"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="27"
rawComment="Extract a range of lines from a file"$'\n'"Argument: startLine - Integer. Required. Starting line number."$'\n'"Argument: endLine - Integer. Required. Ending line number."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Reads lines until EOF"$'\n'"stdout: Outputs the selected lines only"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="27"
stdin="Reads lines until EOF"$'\n'""
stdout="Outputs the selected lines only"$'\n'""
summary="Extract a range of lines from a file"
summaryComputed="true"
usage="fileExtractLines startLine endLine [ --help ]"
