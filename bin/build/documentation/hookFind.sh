#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"--next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"hookName0 - String. Required. Hook to locate"$'\n'"hookName1 - String. Optional. Additional hooks to locate."$'\n'""
base="hook.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does a hook exist in the local project?"$'\n'""$'\n'"Find the path to a hook. The search path is:"$'\n'""$'\n'"- \`./bin/hooks/\`"$'\n'"- \`./bin/build/hooks/\`"$'\n'""$'\n'"If a file named \`hookName\` with the extension \`.sh\` is found which is executable, it is output."$'\n'""$'\n'""
descriptionLineCount="9"
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""
file="bin/build/tools/hook.sh"
fn="hookFind"
fnMarker="hookfind"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="test")
line="282"
rawComment="Summary: Find the path to a hook binary file"$'\n'"Does a hook exist in the local project?"$'\n'"Find the path to a hook. The search path is:"$'\n'"- \`./bin/hooks/\`"$'\n'"- \`./bin/build/hooks/\`"$'\n'"If a file named \`hookName\` with the extension \`.sh\` is found which is executable, it is output."$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"Argument: --next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"Argument: hookName0 - String. Required. Hook to locate"$'\n'"Argument: hookName1 - String. Optional. Additional hooks to locate."$'\n'"Environment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'"Test: testHookSystem"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceHash="d73ad55665973abb9a6ef49bd10909b83e0cc3a0"
sourceLine="282"
summary="Find the path to a hook binary file"
summaryComputed=""
test="testHookSystem"$'\n'""
usage="hookFind [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] hookName0 [ hookName1 ]"
