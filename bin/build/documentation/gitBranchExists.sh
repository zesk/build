#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="branch ... - String. Required. List of branch names to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does a branch exist locally or remotely?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitBranchExists"
fnMarker="gitbranchexists"
foundNames=([0]="argument" [1]="return_code")
line="1016"
rawComment="Does a branch exist locally or remotely?"$'\n'"Argument: branch ... - String. Required. List of branch names to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All branches passed exist"$'\n'"Return Code: 1 - At least one branch does not exist locally or remotely"$'\n'""$'\n'""
return_code="0 - All branches passed exist"$'\n'"1 - At least one branch does not exist locally or remotely"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="1016"
summary="Does a branch exist locally or remotely?"
summaryComputed="true"
usage="gitBranchExists branch ... [ --help ]"
