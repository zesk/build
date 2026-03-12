#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="none"
base="prompt.sh"
build_debug="term-colors - When \`bashPromptModule_TermColors\` is enabled, will show colors and how they are applied"$'\n'""
description="Sets the console colors based on the project you are currently in."$'\n'"Define your color configuration file (values of \`bg=FFF\` etc. one per line, comments allowed)"$'\n'"Will fill in missing bright or non-bright colors which are unspecified. (\`blue\` implies \`br_blue\` and so on)"$'\n'"Sets \`decorateStyle\` for valid styles"$'\n'"Support for iTerm2 is built-in and automatic"$'\n'""
environment="BUILD_TERM_COLORS_STATE"$'\n'""
example="    bashPrompt --order 80 bashPromptModule_TermColors"$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPromptModule_TermColors"
foundNames=([0]="see" [1]="file" [2]="example" [3]="requires" [4]="build_debug" [5]="environment")
rawComment="Sets the console colors based on the project you are currently in."$'\n'"Define your color configuration file (values of \`bg=FFF\` etc. one per line, comments allowed)"$'\n'"Will fill in missing bright or non-bright colors which are unspecified. (\`blue\` implies \`br_blue\` and so on)"$'\n'"Sets \`decorateStyle\` for valid styles"$'\n'"See: consoleConfigureColorMode"$'\n'"File: ./etc/iterm2-colors.conf"$'\n'"File: ./etc/term-colors.conf"$'\n'"File: ./.term-colors.conf"$'\n'"Example:     bashPrompt --order 80 bashPromptModule_TermColors"$'\n'"Requires: buildHome statusMessage buildEnvironmentGetDirectory directoryRequire  shaPipe --cachedecorate buildDebugEnabled iTerm2SetColors consoleConfigureColorMode"$'\n'"BUILD_DEBUG: term-colors - When \`bashPromptModule_TermColors\` is enabled, will show colors and how they are applied"$'\n'"Support for iTerm2 is built-in and automatic"$'\n'"Environment: BUILD_TERM_COLORS_STATE"$'\n'""$'\n'""
requires="buildHome statusMessage buildEnvironmentGetDirectory directoryRequire  shaPipe --cachedecorate buildDebugEnabled iTerm2SetColors consoleConfigureColorMode"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="consoleConfigureColorMode"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="6366b89e08fb52dd710f1f586d8a48d1dab1509d"
summary="Sets the console colors based on the project you are"
summaryComputed="true"
usage="bashPromptModule_TermColors"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
