#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"url - URL. Required. URL to check."$'\n'"file - File. Required. File to compare."$'\n'""
base="web.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Compare a remote file size with a local file size"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/web.sh"
fn="urlMatchesLocalFileSize"
fnMarker="urlmatcheslocalfilesize"
foundNames=([0]="argument")
line="13"
rawComment="Compare a remote file size with a local file size"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url - URL. Required. URL to check."$'\n'"Argument: file - File. Required. File to compare."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceHash="e13b8cb53898482442171ddd6250196c36d71146"
sourceLine="13"
summary="Compare a remote file size with a local file size"
summaryComputed="true"
usage="urlMatchesLocalFileSize [ --help ] url file"
