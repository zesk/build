#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--application - Directory. Optional. Path to application home."$'\n'"--copy - Flag. Optional. Do not execute the hook if it has changed."$'\n'"hook - A hook to install. Maps to \`git-hook\` internally. Will be executed in-place if it has changed from the original."$'\n'""
base="git.sh"
description="Install the most recent version of this hook and RUN IT in place if it has changed."$'\n'"You should ONLY run this from within your hook, or provide the \`--copy\` flag to just copy."$'\n'"When running within your hook, pass additional arguments so they can be preserved:"$'\n'""$'\n'"    gitInstallHook --application \"\$myHome\" pre-commit \"\$@\" || return \$?"$'\n'""$'\n'"Return Code: 0 - the file was not updated"$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'""
environment="BUILD-HOME - The default application home directory used for \`.git\` and build hooks."$'\n'""
file="bin/build/tools/git.sh"
fn="gitInstallHook"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Install the most recent version of this hook and RUN"
usage="gitInstallHook [ --application ] [ --copy ] [ hook ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitInstallHook[0m [94m[ --application ][0m [94m[ --copy ][0m [94m[ hook ][0m

    [94m--application  [1;97mDirectory. Optional. Path to application home.[0m
    [94m--copy         [1;97mFlag. Optional. Do not execute the hook if it has changed.[0m
    [94mhook           [1;97mA hook to install. Maps to [38;2;0;255;0;48;2;0;0;0mgit-hook[0m internally. Will be executed in-place if it has changed from the original.[0m

Install the most recent version of this hook and RUN IT in place if it has changed.
You should ONLY run this from within your hook, or provide the [38;2;0;255;0;48;2;0;0;0m--copy[0m flag to just copy.
When running within your hook, pass additional arguments so they can be preserved:

    gitInstallHook --application "$myHome" pre-commit "$@" || return $?

Return Code: 0 - the file was not updated
Return Code: 1 - Environment error
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD-HOME - The default application home directory used for [38;2;0;255;0;48;2;0;0;0m.git[0m and build hooks.
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitInstallHook [ --application ] [ --copy ] [ hook ]

    --application  Directory. Optional. Path to application home.
    --copy         Flag. Optional. Do not execute the hook if it has changed.
    hook           A hook to install. Maps to git-hook internally. Will be executed in-place if it has changed from the original.

Install the most recent version of this hook and RUN IT in place if it has changed.
You should ONLY run this from within your hook, or provide the --copy flag to just copy.
When running within your hook, pass additional arguments so they can be preserved:

    gitInstallHook --application "$myHome" pre-commit "$@" || return $?

Return Code: 0 - the file was not updated
Return Code: 1 - Environment error
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD-HOME - The default application home directory used for .git and build hooks.
- 
'
