#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"tag - The tag to delete locally and at origin"$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Delete git tag locally and at origin"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitTagDelete"
fnMarker="gittagdelete"
foundNames=([0]="argument" [1]="return_code")
line="87"
rawComment="Delete git tag locally and at origin"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: tag - The tag to delete locally and at origin"$'\n'"Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur."$'\n'""$'\n'""
return_code="argument - Any stage fails will result in this exit code. Partial deletion may occur."$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="87"
summary="Delete git tag locally and at origin"
summaryComputed="true"
usage="gitTagDelete [ --help ] [ tag ]"
