#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Interactive mode on fixing errors."$'\n'"--home home - Directory. Optional. Sanitize files starting here. (Defaults to \`buildHome\`)"$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"--check checkDirectory - Directory. Optional. Check shell scripts in this directory for common errors."$'\n'"... - Additional arguments are passed to \`bashLintFiles\` \`validateFileContents\`"$'\n'""
base="bash.sh"
description="Sanitize bash files for code quality."$'\n'""$'\n'"Configuration File: bashSanitize.conf (file containing simple \`stringContains\` matches to skip file NAMES, one per line, e.g. \`etc/docker\`)"$'\n'"used in find \`find ... ! -path '*LINE*'\` and in grep -e 'LINE'"$'\n'"TODO - use one mechanism for bashSanitize.conf format"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashSanitize"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1769063211"
summary="Sanitize bash files for code quality."
usage="bashSanitize [ --help ] [ -- ] [ --home home ] [ --interactive ] [ --check checkDirectory ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashSanitize[0m [94m[ --help ][0m [94m[ -- ][0m [94m[ --home home ][0m [94m[ --interactive ][0m [94m[ --check checkDirectory ][0m [94m[ ... ][0m

    [94m--help                  [1;97mFlag. Optional. Display this help.[0m
    [94m--                      [1;97mFlag. Optional. Interactive mode on fixing errors.[0m
    [94m--home home             [1;97mDirectory. Optional. Sanitize files starting here. (Defaults to [38;2;0;255;0;48;2;0;0;0mbuildHome[0m)[0m
    [94m--interactive           [1;97mFlag. Optional. Interactive mode on fixing errors.[0m
    [94m--check checkDirectory  [1;97mDirectory. Optional. Check shell scripts in this directory for common errors.[0m
    [94m...                     [1;97mAdditional arguments are passed to [38;2;0;255;0;48;2;0;0;0mbashLintFiles[0m [38;2;0;255;0;48;2;0;0;0mvalidateFileContents[0m[0m

Sanitize bash files for code quality.

Configuration File: bashSanitize.conf (file containing simple [38;2;0;255;0;48;2;0;0;0mstringContains[0m matches to skip file NAMES, one per line, e.g. [38;2;0;255;0;48;2;0;0;0metc/docker[0m)
used in find [38;2;0;255;0;48;2;0;0;0mfind ... ! -path '\''[36mLINE[0m'\''[0m and in grep -e '\''LINE'\''
TODO - use one mechanism for bashSanitize.conf format

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashSanitize [ --help ] [ -- ] [ --home home ] [ --interactive ] [ --check checkDirectory ] [ ... ]

    --help                  Flag. Optional. Display this help.
    --                      Flag. Optional. Interactive mode on fixing errors.
    --home home             Directory. Optional. Sanitize files starting here. (Defaults to buildHome)
    --interactive           Flag. Optional. Interactive mode on fixing errors.
    --check checkDirectory  Directory. Optional. Check shell scripts in this directory for common errors.
    ...                     Additional arguments are passed to bashLintFiles validateFileContents

Sanitize bash files for code quality.

Configuration File: bashSanitize.conf (file containing simple stringContains matches to skip file NAMES, one per line, e.g. etc/docker)
used in find find ... ! -path '\''LINE'\'' and in grep -e '\''LINE'\''
TODO - use one mechanism for bashSanitize.conf format

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
