#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Do any tags exist at all in \`git\`?"$'\n'"May need to \`git pull --tags\`, or no tags exist."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/git.sh"
fn="gitHasAnyRefs"
fnMarker="githasanyrefs"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="691"
rawComment="Summary: Does git have any tags?"$'\n'"Do any tags exist at all in \`git\`?"$'\n'"May need to \`git pull --tags\`, or no tags exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - At least one tag exists"$'\n'"Return Code: 1 - No tags exist"$'\n'""$'\n'""
return_code="0 - At least one tag exists"$'\n'"1 - No tags exist"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="691"
summary="Does git have any tags?"
summaryComputed=""
usage="gitHasAnyRefs [ --help ]"
