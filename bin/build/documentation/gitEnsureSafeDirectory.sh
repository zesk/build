#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"directory - Directory. Required. The directory to add to the \`git\` \`safe.directory\` configuration directive"$'\n'""
base="git.sh"
description="When running git operations on a deployment host, at times it's necessary to"$'\n'"add the current directory (or a directory) to the git \`safe.directory\` directive."$'\n'""$'\n'"This adds the directory passed to that directory in the local user's environment"$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument is not a valid directory"$'\n'"Return Code: Other - git config error codes"$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitEnsureSafeDirectory"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768695708"
summary="When running git operations on a deployment host, at times"
usage="gitEnsureSafeDirectory [ --help ] directory"
