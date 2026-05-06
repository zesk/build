#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--application - Directory. Optional. Path to application home."$'\n'"--copy - Flag. Optional. Do not execute the hook if it has changed."$'\n'"hook - A hook to install. Maps to \`git-hook\` internally. Will be executed in-place if it has changed from the original."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install the most recent version of this hook and RUN IT in place if it has changed."$'\n'"You should ONLY run this from within your hook, or provide the \`--copy\` flag to just copy."$'\n'"When running within your hook, pass additional arguments so they can be preserved:"$'\n'""$'\n'"    gitInstallHook --application \"\$myHome\" pre-commit \"\$@\" || return \$?"$'\n'""$'\n'""
descriptionLineCount="6"
environment="BUILD-HOME - The default application home directory used for \`.git\` and build hooks."$'\n'""
file="bin/build/tools/git.sh"
fn="gitInstallHook"
fnMarker="gitinstallhook"
foundNames=([0]="argument" [1]="return_code" [2]="environment")
line="811"
rawComment="Argument: --application - Directory. Optional. Path to application home."$'\n'"Argument: --copy - Flag. Optional. Do not execute the hook if it has changed."$'\n'"Argument: hook - A hook to install. Maps to \`git-hook\` internally. Will be executed in-place if it has changed from the original."$'\n'"Install the most recent version of this hook and RUN IT in place if it has changed."$'\n'"You should ONLY run this from within your hook, or provide the \`--copy\` flag to just copy."$'\n'"When running within your hook, pass additional arguments so they can be preserved:"$'\n'"    gitInstallHook --application \"\$myHome\" pre-commit \"\$@\" || return \$?"$'\n'"Return Code: 0 - the file was not updated"$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'"Environment: BUILD-HOME - The default application home directory used for \`.git\` and build hooks."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - the file was not updated"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="811"
summary="Install the most recent version of this hook and RUN"
summaryComputed="true"
usage="gitInstallHook [ --application ] [ --copy ] [ hook ] [ --help ]"
