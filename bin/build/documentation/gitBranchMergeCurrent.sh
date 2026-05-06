#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="branch - String. Required. Branch to merge the current branch with."$'\n'"--skip-ip - Boolean. Optional. Do not add the IP address to the comment."$'\n'"--comment - String. Optional. Comment for merge commit."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Merge the current branch with another, push to remote, and then return to the original branch."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitBranchMergeCurrent"
fnMarker="gitbranchmergecurrent"
foundNames=([0]="argument")
line="1140"
rawComment="Merge the current branch with another, push to remote, and then return to the original branch."$'\n'"Argument: branch - String. Required. Branch to merge the current branch with."$'\n'"Argument: --skip-ip - Boolean. Optional. Do not add the IP address to the comment."$'\n'"Argument: --comment - String. Optional. Comment for merge commit."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="1140"
summary="Merge the current branch with another, push to remote, and"
summaryComputed="true"
usage="gitBranchMergeCurrent branch [ --skip-ip ] [ --comment ] [ --help ]"
