#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="tag - String. Optional. The tag to tag again."$'\n'""
base="git.sh"
description="Remove a tag everywhere and tag again on the current branch"$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitTagAgain"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Remove a tag everywhere and tag again on the current"
usage="gitTagAgain [ tag ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitTagAgain[0m [94m[ tag ][0m

    [94mtag  [1;97mString. Optional. The tag to tag again.[0m

Remove a tag everywhere and tag again on the current branch

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitTagAgain [ tag ]

    tag  String. Optional. The tag to tag again.

Remove a tag everywhere and tag again on the current branch

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
