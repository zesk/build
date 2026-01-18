#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hook.sh"
argument="--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"--next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"hookName0 - String. Required. Hook to locate"$'\n'"hookName1 - String. Optional. Additional hooks to locate."$'\n'""
base="hook.sh"
description="Does a hook exist in the local project?"$'\n'""$'\n'"Find the path to a hook. The search path is:"$'\n'""$'\n'"- \`./bin/hooks/\`"$'\n'"- \`./bin/build/hooks/\`"$'\n'""$'\n'"If a file named \`hookName\` with the extension \`.sh\` is found which is executable, it is output."$'\n'""
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""
file="bin/build/tools/hook.sh"
fn="whichHook"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="test")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/hook.sh"
sourceModified="1768695708"
summary="Find the path to a hook binary file"$'\n'""
test="testHookSystem"$'\n'""
usage="whichHook [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] hookName0 [ hookName1 ]"
