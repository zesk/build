#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="prompt.sh"
build_debug="term-colors - When \`bashPromptModule_TermColors\` is enabled, will show colors and how they are applied"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Sets the console colors based on the project you are currently in."$'\n'"Define your color configuration file (values of \`bg=FFF\` etc. one per line, comments allowed)"$'\n'""$'\n'"Will fill in missing bright or non-bright colors which are unspecified. (\`blue\` implies \`br_blue\` and so on)"$'\n'""$'\n'"Sets \`decorateStyle\` for valid styles"$'\n'""$'\n'"Support for iTerm2 is built-in and automatic"$'\n'""$'\n'""
descriptionLineCount="9"
environment="BUILD_TERM_COLORS_STATE"$'\n'""
example="    bashPrompt --order 80 bashPromptModule_TermColors"$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPromptModule_TermColors"
fnMarker="bashpromptmodule_termcolors"
foundNames=([0]="see" [1]="file" [2]="example" [3]="requires" [4]="build_debug" [5]="environment")
line="237"
rawComment="Sets the console colors based on the project you are currently in."$'\n'"Define your color configuration file (values of \`bg=FFF\` etc. one per line, comments allowed)"$'\n'"Will fill in missing bright or non-bright colors which are unspecified. (\`blue\` implies \`br_blue\` and so on)"$'\n'"Sets \`decorateStyle\` for valid styles"$'\n'"See: consoleConfigureColorMode"$'\n'"File: ./etc/iterm2-colors.conf"$'\n'"File: ./etc/term-colors.conf"$'\n'"File: ./.term-colors.conf"$'\n'"Example:     bashPrompt --order 80 bashPromptModule_TermColors"$'\n'"Requires: buildHome statusMessage buildEnvironmentGetDirectory directoryRequire  textSHA --cachedecorate buildDebugEnabled iTerm2SetColors consoleConfigureColorMode"$'\n'"BUILD_DEBUG: term-colors - When \`bashPromptModule_TermColors\` is enabled, will show colors and how they are applied"$'\n'"Support for iTerm2 is built-in and automatic"$'\n'"Environment: BUILD_TERM_COLORS_STATE"$'\n'""$'\n'""
requires="buildHome statusMessage buildEnvironmentGetDirectory directoryRequire  textSHA --cachedecorate buildDebugEnabled iTerm2SetColors consoleConfigureColorMode"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="consoleConfigureColorMode"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="b61c792ae723865297730f9775c4f0b5fcba937d"
sourceLine="237"
summary="Sets the console colors based on the project you are"
summaryComputed="true"
usage="bashPromptModule_TermColors"
