#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Clean up after our pre-commit (deletes cache directory)"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitPreCommitCleanup"
fnMarker="gitprecommitcleanup"
foundNames=([0]="argument")
line="998"
rawComment="Clean up after our pre-commit (deletes cache directory)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="998"
summary="Clean up after our pre-commit (deletes cache directory)"
summaryComputed="true"
usage="gitPreCommitCleanup [ --help ]"
