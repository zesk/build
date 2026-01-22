#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hook.sh"
argument="--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"--next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"hookName0 - one or more hook names which must exist"$'\n'""
base="hook.sh"
description="Does a hook exist in the local project?"$'\n'""$'\n'"Check if one or more hook exists. All hooks must exist to succeed."$'\n'"Return Code: 0 - If all hooks exist"$'\n'""
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""
file="bin/build/tools/hook.sh"
fn="hasHook"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceModified="1769063211"
summary="Determine if a hook exists"$'\n'""
test="testHookSystem"$'\n'""
usage="hasHook [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] [ hookName0 ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mhasHook[0m [94m[ --application applicationHome ][0m [94m[ --extensions extensionList ][0m [94m[ --next scriptName ][0m [94m[ hookName0 ][0m

    [94m--application applicationHome  [1;97mPath. Optional. Directory of alternate application home. Can be specified more than once to change state.[0m
    [94m--extensions extensionList     [1;97mColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_HOOK_EXTENSIONS[0m.[0m
    [94m--next scriptName              [1;97mFile. Optional. Locate the script found [36mafter[0m the named script, if any. Allows easy chaining of scripts.[0m
    [94mhookName0                      [1;97mone or more hook names which must exist[0m

Does a hook exist in the local project?

Check if one or more hook exists. All hooks must exist to succeed.
Return Code: 0 - If all hooks exist

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: hasHook [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] [ hookName0 ]

    --application applicationHome  Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
    --extensions extensionList     ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to BUILD_HOOK_EXTENSIONS.
    --next scriptName              File. Optional. Locate the script found after the named script, if any. Allows easy chaining of scripts.
    hookName0                      one or more hook names which must exist

Does a hook exist in the local project?

Check if one or more hook exists. All hooks must exist to succeed.
Return Code: 0 - If all hooks exist

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG
- 
'
