#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hook.sh"
argument="--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"--next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"hookName0 - String. Required. Hook to locate"$'\n'"hookName1 - String. Optional. Additional hooks to locate."$'\n'""
base="hook.sh"
description="Does a hook exist in the local project?"$'\n'""$'\n'"Find the path to a hook. The search path is:"$'\n'""$'\n'"- \`./bin/hooks/\`"$'\n'"- \`./bin/build/hooks/\`"$'\n'""$'\n'"If a file named \`hookName\` with the extension \`.sh\` is found which is executable, it is output."$'\n'""
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""
file="bin/build/tools/hook.sh"
fn="whichHook"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceModified="1768721469"
summary="Find the path to a hook binary file"$'\n'""
test="testHookSystem"$'\n'""
usage="whichHook [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] hookName0 [ hookName1 ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mwhichHook[0m [94m[ --application applicationHome ][0m [94m[ --extensions extensionList ][0m [94m[ --next scriptName ][0m [38;2;255;255;0m[35;48;2;0;0;0mhookName0[0m[0m [94m[ hookName1 ][0m

    [94m--application applicationHome  [1;97mPath. Optional. Directory of alternate application home. Can be specified more than once to change state.[0m
    [94m--extensions extensionList     [1;97mColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_HOOK_EXTENSIONS[0m.[0m
    [94m--next scriptName              [1;97mFile. Optional. Locate the script found [36mafter[0m the named script, if any. Allows easy chaining of scripts.[0m
    [31mhookName0                      [1;97mString. Required. Hook to locate[0m
    [94mhookName1                      [1;97mString. Optional. Additional hooks to locate.[0m

Does a hook exist in the local project?

Find the path to a hook. The search path is:

- [38;2;0;255;0;48;2;0;0;0m./bin/hooks/[0m
- [38;2;0;255;0;48;2;0;0;0m./bin/build/hooks/[0m

If a file named [38;2;0;255;0;48;2;0;0;0mhookName[0m with the extension [38;2;0;255;0;48;2;0;0;0m.sh[0m is found which is executable, it is output.

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
helpPlain='Usage: whichHook [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] hookName0 [ hookName1 ]

    --application applicationHome  Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
    --extensions extensionList     ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to BUILD_HOOK_EXTENSIONS.
    --next scriptName              File. Optional. Locate the script found after the named script, if any. Allows easy chaining of scripts.
    hookName0                      String. Required. Hook to locate
    hookName1                      String. Optional. Additional hooks to locate.

Does a hook exist in the local project?

Find the path to a hook. The search path is:

- ./bin/hooks/
- ./bin/build/hooks/

If a file named hookName with the extension .sh is found which is executable, it is output.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG
- 
'
