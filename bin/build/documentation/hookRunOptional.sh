#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"hookName - String. Required. Hook name to run."$'\n'"... - Arguments. Optional. Any arguments to the hook. See each hook implementation for details."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="hook.sh"
build_debug="hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Identical to \`hookRun\` but returns exit code zero if the hook does not exist."$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_HOOK_EXTENSIONS"$'\n'"BUILD_HOOK_DIRS"$'\n'""
example="    version=\"\$(hookRunOptional version-current)\""$'\n'""
file="bin/build/tools/hook.sh"
fn="hookRunOptional"
fnMarker="hookrunoptional"
foundNames=([0]="argument" [1]="return_code" [2]="example" [3]="see" [4]="test" [5]="environment" [6]="build_debug")
line="154"
rawComment="Identical to \`hookRun\` but returns exit code zero if the hook does not exist."$'\n'"Argument: --next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"Argument: hookName - String. Required. Hook name to run."$'\n'"Argument: ... - Arguments. Optional. Any arguments to the hook. See each hook implementation for details."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: Any - The hook exit code is returned if it is run"$'\n'"Return Code: 1 - is returned if the hook is not found"$'\n'"Example:     version=\"\$({fn} version-current)\""$'\n'"See: hooks.md hookRunOptional hookRun"$'\n'"Test: testHookSystem"$'\n'"Environment: BUILD_HOOK_EXTENSIONS"$'\n'"Environment: BUILD_HOOK_DIRS"$'\n'"BUILD_DEBUG: hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""$'\n'""
return_code="Any - The hook exit code is returned if it is run"$'\n'"1 - is returned if the hook is not found"$'\n'""
see="hooks.md hookRunOptional hookRun"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceHash="d73ad55665973abb9a6ef49bd10909b83e0cc3a0"
sourceLine="154"
summary="Identical to \`hookRun\` but returns exit code zero if the"
summaryComputed="true"
test="testHookSystem"$'\n'""
usage="hookRunOptional [ --next scriptName ] [ --application applicationHome ] [ --extensions extensionList ] hookName [ ... ] [ --help ]"
version=""
