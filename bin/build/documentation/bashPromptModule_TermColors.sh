#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
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
line="237"
lowerFn="bashpromptmodule_termcolors"
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
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptModule_TermColors'$'\e''[0m'$'\n'''$'\n''Sets the console colors based on the project you are currently in.'$'\n''Define your color configuration file (values of '$'\e''[[(code)]mbg=FFF'$'\e''[[(reset)]m etc. one per line, comments allowed)'$'\n''Will fill in missing bright or non-bright colors which are unspecified. ('$'\e''[[(code)]mblue'$'\e''[[(reset)]m implies '$'\e''[[(code)]mbr_blue'$'\e''[[(reset)]m and so on)'$'\n''Sets '$'\e''[[(code)]mdecorateStyle'$'\e''[[(reset)]m for valid styles'$'\n''Support for iTerm2 is built-in and automatic'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_TERM_COLORS_STATE'$'\n'''$'\n''Example:'$'\n''    bashPrompt --order 80 bashPromptModule_TermColors'$'\n'''$'\n'''$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m settings:'$'\n''- '$'\e''[[(code)]mterm-colors'$'\e''[[(reset)]m - When '$'\e''[[(code)]mbashPromptModule_TermColors'$'\e''[[(reset)]m is enabled, will show colors and how they are applied'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptModule_TermColors'$'\n'''$'\n''Sets the console colors based on the project you are currently in.'$'\n''Define your color configuration file (values of bg=FFF etc. one per line, comments allowed)'$'\n''Will fill in missing bright or non-bright colors which are unspecified. (blue implies br_blue and so on)'$'\n''Sets decorateStyle for valid styles'$'\n''Support for iTerm2 is built-in and automatic'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_TERM_COLORS_STATE'$'\n'''$'\n''Example:'$'\n''    bashPrompt --order 80 bashPromptModule_TermColors'$'\n'''$'\n''BUILD_DEBUG settings:'$'\n''- term-colors - When bashPromptModule_TermColors is enabled, will show colors and how they are applied'$'\n'''
documentationPath="documentation/source/tools/prompt.md"
