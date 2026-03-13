#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--last - Flag. Optional. Append last comment"$'\n'"-- - Flag. Optional. Skip updating release notes with comment."$'\n'"--help - Flag. Optional. I need somebody."$'\n'"comment - Text. Optional. A text comment for release notes and describing in general terms, what was done for a commit message."$'\n'""
base="git.sh"
description="Commits all files added to git and also update release notes with comment"$'\n'"Comment wisely. Does not duplicate comments. Check your release notes."$'\n'"Example:"$'\n'""
example="    c last"$'\n'"    c --last"$'\n'"    c --"$'\n'"... are all equivalent."$'\n'""
file="bin/build/tools/git.sh"
fn="gitCommit"
foundNames=([0]="argument" [1]="example")
rawComment="Argument: --last - Flag. Optional. Append last comment"$'\n'"Argument: -- - Flag. Optional. Skip updating release notes with comment."$'\n'"Argument: --help - Flag. Optional. I need somebody."$'\n'"Argument: comment - Text. Optional. A text comment for release notes and describing in general terms, what was done for a commit message."$'\n'"Commits all files added to git and also update release notes with comment"$'\n'"Comment wisely. Does not duplicate comments. Check your release notes."$'\n'"Example:     c last"$'\n'"Example:     c --last"$'\n'"Example:     c --"$'\n'"Example:"$'\n'"Example: ... are all equivalent."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="45b6673cbbcdf6c9e5146a922f9b837146aa0ed8"
summary="Commits all files added to git and also update release"
summaryComputed="true"
usage="gitCommit [ --last ] [ -- ] [ --help ] [ comment ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitCommit'$'\e''[0m '$'\e''[[(blue)]m[ --last ]'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ comment ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--last   '$'\e''[[(value)]mFlag. Optional. Append last comment'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--       '$'\e''[[(value)]mFlag. Optional. Skip updating release notes with comment.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. I need somebody.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mcomment  '$'\e''[[(value)]mText. Optional. A text comment for release notes and describing in general terms, what was done for a commit message.'$'\e''[[(reset)]m'$'\n'''$'\n''Commits all files added to git and also update release notes with comment'$'\n''Comment wisely. Does not duplicate comments. Check your release notes.'$'\n''Example:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    c last'$'\n''    c --last'$'\n''    c --'$'\n''... are all equivalent.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitCommit [ --last ] [ -- ] [ --help ] [ comment ]'$'\n'''$'\n''    --last   Flag. Optional. Append last comment'$'\n''    --       Flag. Optional. Skip updating release notes with comment.'$'\n''    --help   Flag. Optional. I need somebody.'$'\n''    comment  Text. Optional. A text comment for release notes and describing in general terms, what was done for a commit message.'$'\n'''$'\n''Commits all files added to git and also update release notes with comment'$'\n''Comment wisely. Does not duplicate comments. Check your release notes.'$'\n''Example:'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    c last'$'\n''    c --last'$'\n''    c --'$'\n''... are all equivalent.'$'\n'''
