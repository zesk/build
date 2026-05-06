#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Are we currently inside a git hook?"$'\n'""$'\n'"Tests non-blank strings in our environment."$'\n'""$'\n'""
descriptionLineCount="4"
environment="GIT_EXEC_PATH - Must be set to pass"$'\n'"GIT_INDEX_FILE - Must be set to pass"$'\n'""
file="bin/build/tools/git.sh"
fn="gitInsideHook"
fnMarker="gitinsidehook"
foundNames=([0]="environment" [1]="return_code")
line="295"
rawComment="Are we currently inside a git hook?"$'\n'"Tests non-blank strings in our environment."$'\n'"Environment: GIT_EXEC_PATH - Must be set to pass"$'\n'"Environment: GIT_INDEX_FILE - Must be set to pass"$'\n'"Return Code: 0 - We are, semantically, inside a git hook"$'\n'"Return Code: 1 - We are NOT, semantically, inside a git hook"$'\n'""$'\n'""
return_code="0 - We are, semantically, inside a git hook"$'\n'"1 - We are NOT, semantically, inside a git hook"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="295"
summary="Are we currently inside a git hook?"
summaryComputed="true"
usage="gitInsideHook"
