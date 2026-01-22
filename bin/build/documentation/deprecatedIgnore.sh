#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="none"
base="deprecated-tools.sh"
description="Output a list of tokens for \`find\` to ignore in deprecated calls"$'\n'"Skips dot directories and release notes by default and any file named \`deprecated.sh\` \`deprecated.txt\` or \`deprecated.md\`."$'\n'""$'\n'""
environment="BUILD_RELEASE_NOTES"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedIgnore"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceModified="1768721469"
summary="Output a list of tokens for \`find\` to ignore in"
usage="deprecatedIgnore"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeprecatedIgnore[0m

Output a list of tokens for [38;2;0;255;0;48;2;0;0;0mfind[0m to ignore in deprecated calls
Skips dot directories and release notes by default and any file named [38;2;0;255;0;48;2;0;0;0mdeprecated.sh[0m [38;2;0;255;0;48;2;0;0;0mdeprecated.txt[0m or [38;2;0;255;0;48;2;0;0;0mdeprecated.md[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_RELEASE_NOTES
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedIgnore

Output a list of tokens for find to ignore in deprecated calls
Skips dot directories and release notes by default and any file named deprecated.sh deprecated.txt or deprecated.md.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_RELEASE_NOTES
- 
'
