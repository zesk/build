#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--last - Flag. Optional. Append last comment"$'\n'"-- - Flag. Optional. Skip updating release notes with comment."$'\n'"--help - Flag. Optional. I need somebody."$'\n'"comment - Text. Optional. A text comment for release notes and describing in general terms, what was done for a commit message."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Commits all files added to git and also update release notes with comment"$'\n'""$'\n'"Comment wisely. Does not duplicate comments. Check your release notes."$'\n'""$'\n'"Example:"$'\n'""$'\n'""
descriptionLineCount="6"
example="    c last"$'\n'"    c --last"$'\n'"    c --"$'\n'"... are all equivalent."$'\n'""
file="bin/build/tools/git.sh"
fn="gitCommit"
fnMarker="gitcommit"
foundNames=([0]="argument" [1]="example")
line="462"
rawComment="Argument: --last - Flag. Optional. Append last comment"$'\n'"Argument: -- - Flag. Optional. Skip updating release notes with comment."$'\n'"Argument: --help - Flag. Optional. I need somebody."$'\n'"Argument: comment - Text. Optional. A text comment for release notes and describing in general terms, what was done for a commit message."$'\n'"Commits all files added to git and also update release notes with comment"$'\n'"Comment wisely. Does not duplicate comments. Check your release notes."$'\n'"Example:     c last"$'\n'"Example:     c --last"$'\n'"Example:     c --"$'\n'"Example:"$'\n'"Example: ... are all equivalent."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="462"
summary="Commits all files added to git and also update release"
summaryComputed="true"
usage="gitCommit [ --last ] [ -- ] [ --help ] [ comment ]"
