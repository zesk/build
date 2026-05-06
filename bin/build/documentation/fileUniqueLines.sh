#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="-n - Flag. Optional. Numeric sort."$'\n'"--verbose - Flag. Optional. Be exceptionally wordy."$'\n'"file - File. Required. File to modify in-place."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove duplicate lines from an input stream and sort."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="fileUniqueLines"
fnMarker="fileuniquelines"
foundNames=([0]="summary" [1]="argument")
line="608"
rawComment="Summary: Sorts and makes all file lines unique"$'\n'"Remove duplicate lines from an input stream and sort."$'\n'"Argument: -n - Flag. Optional. Numeric sort."$'\n'"Argument: --verbose - Flag. Optional. Be exceptionally wordy."$'\n'"Argument: file - File. Required. File to modify in-place."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="608"
summary="Sorts and makes all file lines unique"
summaryComputed=""
usage="fileUniqueLines [ -n ] [ --verbose ] file [ --help ]"
