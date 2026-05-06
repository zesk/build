#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"--next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"hookName0 - one or more hook names which must exist"$'\n'""
base="hook.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does a hook exist in the local project?"$'\n'""$'\n'"Check if one or more hook exists. All hooks must exist to succeed."$'\n'""$'\n'""
descriptionLineCount="4"
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""
file="bin/build/tools/hook.sh"
fn="hookExists"
fnMarker="hookexists"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="test" [4]="environment")
line="229"
rawComment="Does a hook exist in the local project?"$'\n'"Check if one or more hook exists. All hooks must exist to succeed."$'\n'"Summary: Determine if a hook exists"$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"Argument: --next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"Argument: hookName0 - one or more hook names which must exist"$'\n'"Return Code: 0 - If all hooks exist"$'\n'"Test: testHookSystem"$'\n'"Environment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""$'\n'""
return_code="0 - If all hooks exist"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceHash="d73ad55665973abb9a6ef49bd10909b83e0cc3a0"
sourceLine="229"
summary="Determine if a hook exists"
summaryComputed=""
test="testHookSystem"$'\n'""
usage="hookExists [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] [ hookName0 ]"
