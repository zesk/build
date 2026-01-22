#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hook.sh"
argument="--application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"hookName ... - String. Required. Hook to source."$'\n'""
base="hook.sh"
build_debug="hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""
description="Run a hook in the project located at \`./bin/hooks/\`"$'\n'""$'\n'"See (Hooks documentation)[../hooks/index.md] for standard hooks."$'\n'""$'\n'"Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at \`./bin/hooks/\` and are named \`hookName\` with a \`.sh\` extension added."$'\n'"So the hook for \`version-current\` would be a file at:"$'\n'""$'\n'"    bin/hooks/version-current.sh"$'\n'""$'\n'"Sample hooks (scripts) can be found in the build source code at \`./bin/hooks/\`."$'\n'""$'\n'"Default hooks (scripts) can be found in the current build version at \`bin/build/hooks/\`"$'\n'""$'\n'"Return Code: Any - The hook exit code is returned if it is run"$'\n'"Return Code: 1 - is returned if the hook is not found"$'\n'""
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""
example="    version=\"\$(hookSource version-current)\""$'\n'""
file="bin/build/tools/hook.sh"
fn="hookSource"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="hooks.md hookRunOptional"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceModified="1768721469"
summary="Run a project hook"$'\n'""
test="testHookSystem"$'\n'""
usage="hookSource [ --application applicationHome ] [ --extensions extensionList ] hookName ..."
version=""
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mhookSource[0m [94m[ --application applicationHome ][0m [94m[ --extensions extensionList ][0m [38;2;255;255;0m[35;48;2;0;0;0mhookName ...[0m[0m

    [94m--application applicationHome  [1;97mPath. Optional. Directory of alternate application home.[0m
    [94m--extensions extensionList     [1;97mColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_HOOK_EXTENSIONS[0m.[0m
    [31mhookName ...                   [1;97mString. Required. Hook to source.[0m

Run a hook in the project located at [38;2;0;255;0;48;2;0;0;0m./bin/hooks/[0m

See (Hooks documentation)[../hooks/index.md] for standard hooks.

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at [38;2;0;255;0;48;2;0;0;0m./bin/hooks/[0m and are named [38;2;0;255;0;48;2;0;0;0mhookName[0m with a [38;2;0;255;0;48;2;0;0;0m.sh[0m extension added.
So the hook for [38;2;0;255;0;48;2;0;0;0mversion-current[0m would be a file at:

    bin/hooks/version-current.sh

Sample hooks (scripts) can be found in the build source code at [38;2;0;255;0;48;2;0;0;0m./bin/hooks/[0m.

Default hooks (scripts) can be found in the current build version at [38;2;0;255;0;48;2;0;0;0mbin/build/hooks/[0m

Return Code: Any - The hook exit code is returned if it is run
Return Code: 1 - is returned if the hook is not found

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG
- 

Example:
    version="$(hookSource version-current)"

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- hook - [38;2;0;255;0;48;2;0;0;0mhookRun[0m and [38;2;0;255;0;48;2;0;0;0mhookSource[0m and optional versions of the same functions will output additional debugging information
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: hookSource [ --application applicationHome ] [ --extensions extensionList ] hookName ...

    --application applicationHome  Path. Optional. Directory of alternate application home.
    --extensions extensionList     ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to BUILD_HOOK_EXTENSIONS.
    hookName ...                   String. Required. Hook to source.

Run a hook in the project located at ./bin/hooks/

See (Hooks documentation)[../hooks/index.md] for standard hooks.

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at ./bin/hooks/ and are named hookName with a .sh extension added.
So the hook for version-current would be a file at:

    bin/hooks/version-current.sh

Sample hooks (scripts) can be found in the build source code at ./bin/hooks/.

Default hooks (scripts) can be found in the current build version at bin/build/hooks/

Return Code: Any - The hook exit code is returned if it is run
Return Code: 1 - is returned if the hook is not found

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG
- 

Example:
    version="$(hookSource version-current)"

BUILD_DEBUG settings:
- hook - hookRun and hookSource and optional versions of the same functions will output additional debugging information
- 
'
