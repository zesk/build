#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--copy - Flag. Optional. Copy the hook but do not execute it."$'\n'"--verbose - Flag. Optional. Be verbose about what is done."$'\n'"--application home - Directory. Optional. Set the application home directory to this prior to looking for hooks."$'\n'"hookName - String. Optional. A hook or hook names to install. See \`gitHookTypes\`"$'\n'""
base="git.sh"
description="Install one or more git hooks from Zesk Build hooks."$'\n'"Zesk Build hooks are named \`git-hookName.sh\` in \`bin/hooks/\` so \`git-pre-commit.sh\` will be installed as the \`pre-commit\` hook for git."$'\n'""$'\n'"Hook types:"$'\n'"- pre-commit"$'\n'"- pre-push"$'\n'"- pre-merge-commit"$'\n'"- pre-rebase"$'\n'"- pre-receive"$'\n'"- update"$'\n'"- post-update"$'\n'"- post-commit"$'\n'""
file="bin/build/tools/git.sh"
fn="gitInstallHooks"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="gitHookTypes"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769063211"
summary="Install one or more git hooks from Zesk Build hooks."
usage="gitInstallHooks [ --copy ] [ --verbose ] [ --application home ] [ hookName ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitInstallHooks[0m [94m[ --copy ][0m [94m[ --verbose ][0m [94m[ --application home ][0m [94m[ hookName ][0m

    [94m--copy              [1;97mFlag. Optional. Copy the hook but do not execute it.[0m
    [94m--verbose           [1;97mFlag. Optional. Be verbose about what is done.[0m
    [94m--application home  [1;97mDirectory. Optional. Set the application home directory to this prior to looking for hooks.[0m
    [94mhookName            [1;97mString. Optional. A hook or hook names to install. See [38;2;0;255;0;48;2;0;0;0mgitHookTypes[0m[0m

Install one or more git hooks from Zesk Build hooks.
Zesk Build hooks are named [38;2;0;255;0;48;2;0;0;0mgit-hookName.sh[0m in [38;2;0;255;0;48;2;0;0;0mbin/hooks/[0m so [38;2;0;255;0;48;2;0;0;0mgit-pre-commit.sh[0m will be installed as the [38;2;0;255;0;48;2;0;0;0mpre-commit[0m hook for git.

Hook types:
- pre-commit
- pre-push
- pre-merge-commit
- pre-rebase
- pre-receive
- update
- post-update
- post-commit

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitInstallHooks [ --copy ] [ --verbose ] [ --application home ] [ hookName ]

    --copy              Flag. Optional. Copy the hook but do not execute it.
    --verbose           Flag. Optional. Be verbose about what is done.
    --application home  Directory. Optional. Set the application home directory to this prior to looking for hooks.
    hookName            String. Optional. A hook or hook names to install. See gitHookTypes

Install one or more git hooks from Zesk Build hooks.
Zesk Build hooks are named git-hookName.sh in bin/hooks/ so git-pre-commit.sh will be installed as the pre-commit hook for git.

Hook types:
- pre-commit
- pre-push
- pre-merge-commit
- pre-rebase
- pre-receive
- update
- post-update
- post-commit

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
