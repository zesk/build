#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/hook.sh"
argument="--application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"--next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"hookName - String. Required. Hook name to run."$'\n'"... - Arguments. Optional. Any arguments to the hook. See each hook implementation for details."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="hook.sh"
build_debug="hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""
description="Run a hook in the project located at \`./bin/hooks/\`"$'\n'""$'\n'"See (Hooks documentation)[../hooks/index.md] for standard hooks."$'\n'""$'\n'"Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at \`./bin/hooks/\` and are named \`hookName\` with a \`.sh\` extension added."$'\n'"So the hook for \`version-current\` would be a file at:"$'\n'""$'\n'"    bin/hooks/version-current.sh"$'\n'""$'\n'"Sample hooks (scripts) can be found in the build source code at \`./bin/hooks/\`."$'\n'""$'\n'"Default hooks (scripts) can be found in the current build version at \`bin/build/hooks/\`"$'\n'""$'\n'"Return Code: Any - The hook exit code is returned if it is run"$'\n'"Return Code: 1 - is returned if the hook is not found"$'\n'""
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""
example="    version=\"\$(hookRun version-current)\""$'\n'""
file="bin/build/tools/hook.sh"
fn="hookRun"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="see" [4]="test" [5]="environment" [6]="build_debug")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="hooks.md hookRunOptional hookRun hookSource hookSourceOptional"$'\n'""
source="bin/build/tools/hook.sh"
sourceModified="1768721469"
summary="Run a project hook"$'\n'""
test="testHookSystem"$'\n'""
usage="hookRun [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] hookName [ ... ] [ --help ]"
