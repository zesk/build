#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'-n - Flag. Optional. Numeric sort.\n--verbose - Flag. Optional. Be exceptionally wordy.\nfile - File. Required. File to modify in-place.\n--help - Flag. Optional. Display this help.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove duplicate lines from an input stream and sort.\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="fileUniqueLines"
fnMarker="fileuniquelines"
foundNames=([0]="summary" [1]="argument")
line="611"
rawComment=$'Summary: Sorts and makes all file lines unique\nRemove duplicate lines from an input stream and sort.\nArgument: -n - Flag. Optional. Numeric sort.\nArgument: --verbose - Flag. Optional. Be exceptionally wordy.\nArgument: file - File. Required. File to modify in-place.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="611"
summary="Sorts and makes all file lines unique"
summaryComputed=""
usage="fileUniqueLines [ -n ] [ --verbose ] file [ --help ]"
