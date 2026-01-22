#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
credits="Tim Perry"$'\n'""
description="Returns 0 if a tty is available, 1 if not. Caches the saved value in \`__BUILD_HAS_TTY\` to avoid running the test each call.ZL"$'\n'""
environment="- \`__BUILD_HAS_TTY\` - Cached value of \`false\` or \`true\`. Any other value forces computation during this call."$'\n'""
file="bin/build/tools/colors.sh"
fn="isTTYAvailable"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty /dev/tty"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1769063211"
summary="Quiet test for a TTY"$'\n'""
url="https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional"$'\n'""
usage="isTTYAvailable [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misTTYAvailable[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Returns 0 if a tty is available, 1 if not. Caches the saved value in [38;2;0;255;0;48;2;0;0;0m__BUILD_HAS_TTY[0m to avoid running the test each call.ZL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- - [38;2;0;255;0;48;2;0;0;0m__BUILD_HAS_TTY[0m - Cached value of [38;2;0;255;0;48;2;0;0;0mfalse[0m or [38;2;0;255;0;48;2;0;0;0mtrue[0m. Any other value forces computation during this call.
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isTTYAvailable [ --help ]

    --help  Flag. Optional. Display this help.

Returns 0 if a tty is available, 1 if not. Caches the saved value in __BUILD_HAS_TTY to avoid running the test each call.ZL

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- - __BUILD_HAS_TTY - Cached value of false or true. Any other value forces computation during this call.
- 
'
