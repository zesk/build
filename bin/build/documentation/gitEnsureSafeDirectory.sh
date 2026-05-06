#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"directory - Directory. Required. The directory to add to the \`git\` \`safe.directory\` configuration directive"$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="When running git operations on a deployment host, at times it's necessary to"$'\n'"add the current directory (or a directory) to the git \`safe.directory\` directive."$'\n'""$'\n'"This adds the directory passed to that directory in the local user's environment"$'\n'""$'\n'""
descriptionLineCount="5"
file="bin/build/tools/git.sh"
fn="gitEnsureSafeDirectory"
fnMarker="gitensuresafedirectory"
foundNames=([0]="argument" [1]="return_code")
line="63"
rawComment="When running git operations on a deployment host, at times it's necessary to"$'\n'"add the current directory (or a directory) to the git \`safe.directory\` directive."$'\n'"This adds the directory passed to that directory in the local user's environment"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: directory - Directory. Required. The directory to add to the \`git\` \`safe.directory\` configuration directive"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument is not a valid directory"$'\n'"Return Code: Other - git config error codes"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"2 - Argument is not a valid directory"$'\n'"Other - git config error codes"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="63"
summary="When running git operations on a deployment host, at times"
summaryComputed="true"
usage="gitEnsureSafeDirectory [ --help ] directory"
