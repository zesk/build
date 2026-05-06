#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Extracts the first comment from a stream"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashRemoveCommentCharacter"
fnMarker="bashremovecommentcharacter"
foundNames=([0]="argument" [1]="requires")
line="595"
rawComment="Extracts the first comment from a stream"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: fileReverseLines sed cut grep convertValue"$'\n'""$'\n'""
requires="fileReverseLines sed cut grep convertValue"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="595"
summary="Extracts the first comment from a stream"
summaryComputed="true"
usage="bashRemoveCommentCharacter [ --help ]"
