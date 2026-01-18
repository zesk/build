#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--last - Flag. Optional. Append last comment"$'\n'"-- - Flag. Optional. Skip updating release notes with comment."$'\n'"--help - Flag. Optional. I need somebody."$'\n'"comment - Text. Optional. A text comment for release notes and describing in general terms, what was done for a commit message."$'\n'""
base="git.sh"
description="Commits all files added to git and also update release notes with comment"$'\n'""$'\n'"Comment wisely. Does not duplicate comments. Check your release notes."$'\n'""$'\n'"Example:"$'\n'""
example="    c last"$'\n'"    c --last"$'\n'"    c --"$'\n'"... are all equivalent."$'\n'""
file="bin/build/tools/git.sh"
fn="gitCommit"
foundNames=([0]="argument" [1]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768721470"
summary="Commits all files added to git and also update release"
usage="gitCommit [ --last ] [ -- ] [ --help ] [ comment ]"
