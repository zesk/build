#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hook.sh"
argument="--next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"hookName - String. Required. Hook name to run."$'\n'"... - Arguments. Optional. Any arguments to the hook. See each hook implementation for details."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="hook.sh"
build_debug="hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""
description="Identical to \`hookRun\` but returns exit code zero if the hook does not exist."$'\n'""$'\n'"Return Code: Any - The hook exit code is returned if it is run"$'\n'"Return Code: 1 - is returned if the hook is not found"$'\n'""
environment="BUILD_HOOK_EXTENSIONS"$'\n'"BUILD_HOOK_DIRS"$'\n'""
example="    version=\"\$(hookRunOptional version-current)\""$'\n'""
file="bin/build/tools/hook.sh"
fn="hookRunOptional"
foundNames=([0]="argument" [1]="example" [2]="see" [3]="test" [4]="environment" [5]="build_debug")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="hooks.md hookRunOptional hookRun"$'\n'""
source="bin/build/tools/hook.sh"
sourceModified="1768683999"
summary="Identical to \`hookRun\` but returns exit code zero if the"
test="testHookSystem"$'\n'""
usage="hookRunOptional [ --next scriptName ] [ --application applicationHome ] [ --extensions extensionList ] hookName [ ... ] [ --help ]"
