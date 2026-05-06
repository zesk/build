#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List the extensions available."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitPreCommitExtensionList"
fnMarker="gitprecommitextensionlist"
foundNames=([0]="argument" [1]="stdout")
line="962"
rawComment="List the extensions available."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: String. One per line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="962"
stdout="String. One per line."$'\n'""
summary="List the extensions available."
summaryComputed="true"
usage="gitPreCommitExtensionList [ --help ]"
