#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"hookName ... - String. Required. Hook to source (if it exists)."$'\n'""
base="hook.sh"
build_debug="hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Identical to \`hookRun\` but returns exit code zero if the hook does not exist."$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_HOOK_EXTENSIONS"$'\n'"BUILD_HOOK_DIRS"$'\n'"BUILD_DEBUG"$'\n'""
example="    hookSourceOptional test-cleanup"$'\n'""
file="bin/build/tools/hook.sh"
fn="hookSourceOptional"
fnMarker="hooksourceoptional"
foundNames=([0]="argument" [1]="return_code" [2]="example" [3]="test" [4]="see" [5]="environment" [6]="build_debug")
line="209"
rawComment="Identical to \`hookRun\` but returns exit code zero if the hook does not exist."$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"Argument: hookName ... - String. Required. Hook to source (if it exists)."$'\n'"Return Code: Any - The hook exit code is returned if it is run"$'\n'"Return Code: 0 - is returned if the hook is not found"$'\n'"Example:     {fn} test-cleanup"$'\n'"Test: testHookSystem"$'\n'"See: hooks.md hookRun"$'\n'"Environment: BUILD_HOOK_EXTENSIONS"$'\n'"Environment: BUILD_HOOK_DIRS"$'\n'"Environment: BUILD_DEBUG"$'\n'"BUILD_DEBUG: hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""$'\n'""
return_code="Any - The hook exit code is returned if it is run"$'\n'"0 - is returned if the hook is not found"$'\n'""
see="hooks.md hookRun"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceHash="d73ad55665973abb9a6ef49bd10909b83e0cc3a0"
sourceLine="209"
summary="Identical to \`hookRun\` but returns exit code zero if the"
summaryComputed="true"
test="testHookSystem"$'\n'""
usage="hookSourceOptional [ --application applicationHome ] [ --extensions extensionList ] hookName ..."
