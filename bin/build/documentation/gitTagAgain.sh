#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="tag - String. Optional. The tag to tag again."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove a tag everywhere and tag again on the current branch"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitTagAgain"
fnMarker="gittagagain"
foundNames=([0]="argument")
line="122"
rawComment="Remove a tag everywhere and tag again on the current branch"$'\n'"Argument: tag - String. Optional. The tag to tag again."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="122"
summary="Remove a tag everywhere and tag again on the current"
summaryComputed="true"
usage="gitTagAgain [ tag ]"
