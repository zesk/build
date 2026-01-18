#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hook.sh"
argument="--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"--next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"hookName0 - one or more hook names which must exist"$'\n'""
base="hook.sh"
description="Does a hook exist in the local project?"$'\n'""$'\n'"Check if one or more hook exists. All hooks must exist to succeed."$'\n'"Return Code: 0 - If all hooks exist"$'\n'""
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""
file="bin/build/tools/hook.sh"
fn="hasHook"
foundNames=([0]="summary" [1]="argument" [2]="test" [3]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/hook.sh"
sourceModified="1768695708"
summary="Determine if a hook exists"$'\n'""
test="testHookSystem"$'\n'""
usage="hasHook [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] [ hookName0 ]"
