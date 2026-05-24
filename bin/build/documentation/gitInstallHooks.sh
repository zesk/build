#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--copy - Flag. Optional. Copy the hook but do not execute it.\n--verbose - Flag. Optional. Be verbose about what is done.\n--application home - Directory. Optional. Set the application home directory to this prior to looking for hooks.\nhookName - String. Optional. A hook or hook names to install. See `gitHookTypes`\n--help - Flag. Optional. Display this help.\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install one or more git hooks from Zesk Build hooks.\nZesk Build hooks are named `git-hookName.sh` in `bin/hooks/` so `git-pre-commit.sh` will be installed as the `pre-commit` hook for git.\n\nHook types:\n- `pre-commit`\n- `pre-push`\n- `pre-merge-commit`\n- `pre-rebase`\n- `pre-receive`\n- `update`\n- `post-update`\n- `post-commit`\n\n'
descriptionLineCount="13"
file="bin/build/tools/git.sh"
fn="gitInstallHooks"
fnMarker="gitinstallhooks"
foundNames=([0]="argument" [1]="see")
line="747"
rawComment=$'Install one or more git hooks from Zesk Build hooks.\nZesk Build hooks are named `git-hookName.sh` in `bin/hooks/` so `git-pre-commit.sh` will be installed as the `pre-commit` hook for git.\nArgument: --copy - Flag. Optional. Copy the hook but do not execute it.\nArgument: --verbose - Flag. Optional. Be verbose about what is done.\nArgument: --application home - Directory. Optional. Set the application home directory to this prior to looking for hooks.\nArgument: hookName - String. Optional. A hook or hook names to install. See `gitHookTypes`\nHook types:\n- `pre-commit`\n- `pre-push`\n- `pre-merge-commit`\n- `pre-rebase`\n- `pre-receive`\n- `update`\n- `post-update`\n- `post-commit`\nSee: gitHookTypes\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'gitHookTypes\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="747"
summary="Install one or more git hooks from Zesk Build hooks."
summaryComputed="true"
usage="gitInstallHooks [ --copy ] [ --verbose ] [ --application home ] [ hookName ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitInstallHooks'$'\e''[0m '$'\e''[[(blue)]m[ --copy ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --application home ]'$'\e''[0m '$'\e''[[(blue)]m[ hookName ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--copy              '$'\e''[[(value)]mFlag. Optional. Copy the hook but do not execute it.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose           '$'\e''[[(value)]mFlag. Optional. Be verbose about what is done.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--application home  '$'\e''[[(value)]mDirectory. Optional. Set the application home directory to this prior to looking for hooks.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mhookName            '$'\e''[[(value)]mString. Optional. A hook or hook names to install. See '$'\e''[[(code)]mgitHookTypes'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help              '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Install one or more git hooks from Zesk Build hooks.'$'\n''Zesk Build hooks are named '$'\e''[[(code)]mgit-hookName.sh'$'\e''[[(reset)]m in '$'\e''[[(code)]mbin/hooks/'$'\e''[[(reset)]m so '$'\e''[[(code)]mgit-pre-commit.sh'$'\e''[[(reset)]m will be installed as the '$'\e''[[(code)]mpre-commit'$'\e''[[(reset)]m hook for git.'$'\n'''$'\n''Hook types:'$'\n''- '$'\e''[[(code)]mpre-commit'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpre-push'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpre-merge-commit'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpre-rebase'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpre-receive'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mupdate'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpost-update'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpost-commit'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitInstallHooks [ --copy ] [ --verbose ] [ --application home ] [ hookName ] [ --help ]'$'\n'''$'\n''    --copy              Flag. Optional. Copy the hook but do not execute it.'$'\n''    --verbose           Flag. Optional. Be verbose about what is done.'$'\n''    --application home  Directory. Optional. Set the application home directory to this prior to looking for hooks.'$'\n''    hookName            String. Optional. A hook or hook names to install. See gitHookTypes'$'\n''    --help              Flag. Optional. Display this help.'$'\n'''$'\n''Install one or more git hooks from Zesk Build hooks.'$'\n''Zesk Build hooks are named git-hookName.sh in bin/hooks/ so git-pre-commit.sh will be installed as the pre-commit hook for git.'$'\n'''$'\n''Hook types:'$'\n''- pre-commit'$'\n''- pre-push'$'\n''- pre-merge-commit'$'\n''- pre-rebase'$'\n''- pre-receive'$'\n''- update'$'\n''- post-update'$'\n''- post-commit'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/git.md"
