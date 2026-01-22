#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="Does git have any tags?"$'\n'"May need to \`git pull --tags\`, or no tags exist."$'\n'""
file="bin/build/tools/git.sh"
fn="gitHasAnyRefs"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769063211"
summary="Does git have any tags?"
usage="gitHasAnyRefs"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitHasAnyRefs[0m

Does git have any tags?
May need to [38;2;0;255;0;48;2;0;0;0mgit pull --tags[0m, or no tags exist.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitHasAnyRefs

Does git have any tags?
May need to git pull --tags, or no tags exist.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
