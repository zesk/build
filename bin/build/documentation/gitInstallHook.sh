#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--application - Directory. Optional.Path to application home."$'\n'"--copy - Flag. Optional.Do not execute the hook if it has changed."$'\n'"hook - A hook to install. Maps to \`git-hook\` internally. Will be executed in-place if it has changed from the original."$'\n'""
base="git.sh"
description="Install the most recent version of this hook and RUN IT in place if it has changed."$'\n'"You should ONLY run this from within your hook, or provide the \`--copy\` flag to just copy."$'\n'"When running within your hook, pass additional arguments so they can be preserved:"$'\n'""$'\n'"    gitInstallHook --application \"\$myHome\" pre-commit \"\$@\" || return \$?"$'\n'""$'\n'"Return Code: 0 - the file was not updated"$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'""
environment="BUILD-HOME - The default application home directory used for \`.git\` and build hooks."$'\n'""
file="bin/build/tools/git.sh"
fn="gitInstallHook"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768695708"
summary="Install the most recent version of this hook and RUN"
usage="gitInstallHook [ --application ] [ --copy ] [ hook ]"
