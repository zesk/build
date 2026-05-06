#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="ignorePattern - Optional. String. Specify a grep pattern to ignore; allows you to ignore current version"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the last reported version."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitVersionLast"
fnMarker="gitversionlast"
foundNames=([0]="argument")
line="164"
rawComment="Get the last reported version."$'\n'"Argument: ignorePattern - Optional. String. Specify a grep pattern to ignore; allows you to ignore current version"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="164"
summary="Get the last reported version."
summaryComputed="true"
usage="gitVersionLast [ ignorePattern ] [ --help ]"
