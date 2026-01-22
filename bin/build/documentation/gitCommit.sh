#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--last - Flag. Optional. Append last comment"$'\n'"-- - Flag. Optional. Skip updating release notes with comment."$'\n'"--help - Flag. Optional. I need somebody."$'\n'"comment - Text. Optional. A text comment for release notes and describing in general terms, what was done for a commit message."$'\n'""
base="git.sh"
description="Commits all files added to git and also update release notes with comment"$'\n'""$'\n'"Comment wisely. Does not duplicate comments. Check your release notes."$'\n'""$'\n'"Example:"$'\n'""
example="    c last"$'\n'"    c --last"$'\n'"    c --"$'\n'"... are all equivalent."$'\n'""
file="bin/build/tools/git.sh"
fn="gitCommit"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Commits all files added to git and also update release"
usage="gitCommit [ --last ] [ -- ] [ --help ] [ comment ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitCommit[0m [94m[ --last ][0m [94m[ -- ][0m [94m[ --help ][0m [94m[ comment ][0m

    [94m--last   [1;97mFlag. Optional. Append last comment[0m
    [94m--       [1;97mFlag. Optional. Skip updating release notes with comment.[0m
    [94m--help   [1;97mFlag. Optional. I need somebody.[0m
    [94mcomment  [1;97mText. Optional. A text comment for release notes and describing in general terms, what was done for a commit message.[0m

Commits all files added to git and also update release notes with comment

Comment wisely. Does not duplicate comments. Check your release notes.

Example:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    c last
    c --last
    c --
... are all equivalent.
'
# shellcheck disable=SC2016
helpPlain='Usage: gitCommit [ --last ] [ -- ] [ --help ] [ comment ]

    --last   Flag. Optional. Append last comment
    --       Flag. Optional. Skip updating release notes with comment.
    --help   Flag. Optional. I need somebody.
    comment  Text. Optional. A text comment for release notes and describing in general terms, what was done for a commit message.

Commits all files added to git and also update release notes with comment

Comment wisely. Does not duplicate comments. Check your release notes.

Example:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    c last
    c --last
    c --
... are all equivalent.
'
