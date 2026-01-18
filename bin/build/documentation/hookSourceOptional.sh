#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hook.sh"
argument="--application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"hookName ... - String. Required. Hook to source (if it exists)."$'\n'""
base="hook.sh"
build_debug="hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""
description="Identical to \`hookRun\` but returns exit code zero if the hook does not exist."$'\n'""$'\n'"Return Code: Any - The hook exit code is returned if it is run"$'\n'"Return Code: 0 - is returned if the hook is not found"$'\n'""
environment="BUILD_HOOK_EXTENSIONS"$'\n'"BUILD_HOOK_DIRS"$'\n'"BUILD_DEBUG"$'\n'""
example="    if ! hookSourceOptional test-cleanup >>\"\$quietLog\"; then"$'\n'"        buildFailed \"\$quietLog\""$'\n'"    fi"$'\n'""
file="bin/build/tools/hook.sh"
fn="hookSourceOptional"
foundNames=([0]="argument" [1]="example" [2]="test" [3]="see" [4]="environment" [5]="build_debug")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="hooks.md hookRun"$'\n'""
source="bin/build/tools/hook.sh"
sourceModified="1768721469"
summary="Identical to \`hookRun\` but returns exit code zero if the"
test="testHookSystem"$'\n'""
usage="hookSourceOptional [ --application applicationHome ] [ --extensions extensionList ] hookName ..."
