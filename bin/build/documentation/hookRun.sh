#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"--next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"hookName - String. Required. Hook name to run."$'\n'"... - Arguments. Optional. Any arguments to the hook. See each hook implementation for details."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="hook.sh"
build_debug="hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run a hook in the project located at \`./bin/hooks/\`"$'\n'""$'\n'"See (Hooks documentation)[../hooks/index.md] for standard hooks."$'\n'""$'\n'"Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at \`./bin/hooks/\` and are named \`hookName\` with a \`.sh\` extension added."$'\n'"So the hook for \`version-current\` would be a file at:"$'\n'""$'\n'"    bin/hooks/version-current.sh"$'\n'""$'\n'"Sample hooks (scripts) can be found in the build source code at \`./bin/hooks/\`."$'\n'""$'\n'"Default hooks (scripts) can be found in the current build version at \`bin/build/hooks/\`"$'\n'""$'\n'""
descriptionLineCount="13"
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'""
example="    version=\"\$(hookRun version-current)\""$'\n'""
file="bin/build/tools/hook.sh"
fn="hookRun"
fnMarker="hookrun"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="example" [4]="see" [5]="test" [6]="environment" [7]="build_debug")
line="128"
rawComment="Run a hook in the project located at \`./bin/hooks/\`"$'\n'"See (Hooks documentation)[../hooks/index.md] for standard hooks."$'\n'"Summary: Run a project hook"$'\n'"Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at \`./bin/hooks/\` and are named \`hookName\` with a \`.sh\` extension added."$'\n'"So the hook for \`version-current\` would be a file at:"$'\n'"    bin/hooks/version-current.sh"$'\n'"Sample hooks (scripts) can be found in the build source code at \`./bin/hooks/\`."$'\n'"Default hooks (scripts) can be found in the current build version at \`bin/build/hooks/\`"$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home."$'\n'"Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to \`BUILD_HOOK_EXTENSIONS\`."$'\n'"Argument: --next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts."$'\n'"Argument: hookName - String. Required. Hook name to run."$'\n'"Argument: ... - Arguments. Optional. Any arguments to the hook. See each hook implementation for details."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: Any - The hook exit code is returned if it is run"$'\n'"Return Code: 1 - is returned if the hook is not found"$'\n'"Example:     version=\"\$({fn} version-current)\""$'\n'"See: hooks.md hookRunOptional hookRun hookSource hookSourceOptional"$'\n'"Test: testHookSystem"$'\n'"Environment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG"$'\n'"BUILD_DEBUG: hook - \`hookRun\` and \`hookSource\` and optional versions of the same functions will output additional debugging information"$'\n'""$'\n'""
return_code="Any - The hook exit code is returned if it is run"$'\n'"1 - is returned if the hook is not found"$'\n'""
see="hooks.md hookRunOptional hookRun hookSource hookSourceOptional"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceHash="d73ad55665973abb9a6ef49bd10909b83e0cc3a0"
sourceLine="128"
summary="Run a project hook"
summaryComputed=""
test="testHookSystem"$'\n'""
usage="hookRun [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] hookName [ ... ] [ --help ]"
version=""
