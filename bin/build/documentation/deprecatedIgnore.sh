#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="none"
base="deprecated-tools.sh"
description="Output a list of tokens for \`find\` to ignore in deprecated calls"$'\n'"Skips dot directories and release notes by default and any file named \`deprecated.sh\` \`deprecated.txt\` or \`deprecated.md\`."$'\n'""
environment="BUILD_RELEASE_NOTES"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedIgnore"
foundNames=([0]="environment")
line="56"
lowerFn="deprecatedignore"
rawComment="Output a list of tokens for \`find\` to ignore in deprecated calls"$'\n'"Skips dot directories and release notes by default and any file named \`deprecated.sh\` \`deprecated.txt\` or \`deprecated.md\`."$'\n'"Environment: BUILD_RELEASE_NOTES"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="77bf8f3ce9a60d43463b21338a93db64ec181cd4"
sourceLine="56"
summary="Output a list of tokens for \`find\` to ignore in"
summaryComputed="true"
usage="deprecatedIgnore"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeprecatedIgnore'$'\e''[0m'$'\n'''$'\n''Output a list of tokens for '$'\e''[[(code)]mfind'$'\e''[[(reset)]m to ignore in deprecated calls'$'\n''Skips dot directories and release notes by default and any file named '$'\e''[[(code)]mdeprecated.sh'$'\e''[[(reset)]m '$'\e''[[(code)]mdeprecated.txt'$'\e''[[(reset)]m or '$'\e''[[(code)]mdeprecated.md'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_RELEASE_NOTES'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedIgnore'$'\n'''$'\n''Output a list of tokens for find to ignore in deprecated calls'$'\n''Skips dot directories and release notes by default and any file named deprecated.sh deprecated.txt or deprecated.md.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_RELEASE_NOTES'$'\n'''
documentationPath="documentation/source/tools/deprecated.md"
