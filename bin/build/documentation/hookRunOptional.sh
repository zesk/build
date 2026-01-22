#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hook.sh"
argument="--next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"hookName - String. Required. Hook name to run."$'\n'"... - Arguments. Optional. Any arguments to the hook. See each hook implementation for details."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="hook.sh"
build_debug="hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""
description="Identical to \`hookRun\` but returns exit code zero if the hook does not exist."$'\n'""$'\n'"Return Code: Any - The hook exit code is returned if it is run"$'\n'"Return Code: 1 - is returned if the hook is not found"$'\n'""
environment="BUILD_HOOK_EXTENSIONS"$'\n'"BUILD_HOOK_DIRS"$'\n'""
example="    version=\"\$(hookRunOptional version-current)\""$'\n'""
file="bin/build/tools/hook.sh"
fn="hookRunOptional"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="hooks.md hookRunOptional hookRun"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceModified="1769063211"
summary="Identical to \`hookRun\` but returns exit code zero if the"
test="testHookSystem"$'\n'""
usage="hookRunOptional [ --next scriptName ] [ --application applicationHome ] [ --extensions extensionList ] hookName [ ... ] [ --help ]"
version=""
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mhookRunOptional[0m [94m[ --next scriptName ][0m [94m[ --application applicationHome ][0m [94m[ --extensions extensionList ][0m [38;2;255;255;0m[35;48;2;0;0;0mhookName[0m[0m [94m[ ... ][0m [94m[ --help ][0m

    [94m--next scriptName              [1;97mFile. Optional. Run the script found [36mafter[0m the named script, if any. Allows easy chaining of scripts.[0m
    [94m--application applicationHome  [1;97mPath. Optional. Directory of alternate application home.[0m
    [94m--extensions extensionList     [1;97mColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_HOOK_EXTENSIONS[0m.[0m
    [31mhookName                       [1;97mString. Required. Hook name to run.[0m
    [94m...                            [1;97mArguments. Optional. Any arguments to the hook. See each hook implementation for details.[0m
    [94m--help                         [1;97mFlag. Optional. Display this help.[0m

Identical to [38;2;0;255;0;48;2;0;0;0mhookRun[0m but returns exit code zero if the hook does not exist.

Return Code: Any - The hook exit code is returned if it is run
Return Code: 1 - is returned if the hook is not found

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_HOOK_EXTENSIONS
- BUILD_HOOK_DIRS
- 

Example:
    version="$(hookRunOptional version-current)"

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- hook - [38;2;0;255;0;48;2;0;0;0mhookRun[0m and [38;2;0;255;0;48;2;0;0;0mhookSource[0m and optional versions of the same functions will output additional debugging information
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: hookRunOptional [ --next scriptName ] [ --application applicationHome ] [ --extensions extensionList ] hookName [ ... ] [ --help ]

    --next scriptName              File. Optional. Run the script found after the named script, if any. Allows easy chaining of scripts.
    --application applicationHome  Path. Optional. Directory of alternate application home.
    --extensions extensionList     ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to BUILD_HOOK_EXTENSIONS.
    hookName                       String. Required. Hook name to run.
    ...                            Arguments. Optional. Any arguments to the hook. See each hook implementation for details.
    --help                         Flag. Optional. Display this help.

Identical to hookRun but returns exit code zero if the hook does not exist.

Return Code: Any - The hook exit code is returned if it is run
Return Code: 1 - is returned if the hook is not found

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_HOOK_EXTENSIONS
- BUILD_HOOK_DIRS
- 

Example:
    version="$(hookRunOptional version-current)"

BUILD_DEBUG settings:
- hook - hookRun and hookSource and optional versions of the same functions will output additional debugging information
- 
'
