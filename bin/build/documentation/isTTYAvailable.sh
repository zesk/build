#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="colors.sh"
description="Summary: Quiet test for a TTY"$'\n'"Returns 0 if a tty is available, 1 if not. Caches the saved value in \`__BUILD_HAS_TTY\` to avoid running the test each call.ZL"$'\n'"See: stty /dev/tty"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: - \`__BUILD_HAS_TTY\` - Cached value of \`false\` or \`true\`. Any other value forces computation during this call."$'\n'"Credits: Tim Perry"$'\n'"URL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional"$'\n'""
file="bin/build/tools/colors.sh"
foundNames=()
rawComment="Summary: Quiet test for a TTY"$'\n'"Returns 0 if a tty is available, 1 if not. Caches the saved value in \`__BUILD_HAS_TTY\` to avoid running the test each call.ZL"$'\n'"See: stty /dev/tty"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: - \`__BUILD_HAS_TTY\` - Cached value of \`false\` or \`true\`. Any other value forces computation during this call."$'\n'"Credits: Tim Perry"$'\n'"URL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="9f54e9ae3d6bd1960826e3412b3edfd9c241f895"
summary="Summary: Quiet test for a TTY"
usage="isTTYAvailable"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misTTYAvailable'$'\e''[0m'$'\n'''$'\n''Summary: Quiet test for a TTY'$'\n''Returns 0 if a tty is available, 1 if not. Caches the saved value in '$'\e''[[(code)]m__BUILD_HAS_TTY'$'\e''[[(reset)]m to avoid running the test each call.ZL'$'\n''See: stty /dev/tty'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Environment: - '$'\e''[[(code)]m__BUILD_HAS_TTY'$'\e''[[(reset)]m - Cached value of '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m or '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m. Any other value forces computation during this call.'$'\n''Credits: Tim Perry'$'\n''URL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isTTYAvailable'$'\n'''$'\n''Summary: Quiet test for a TTY'$'\n''Returns 0 if a tty is available, 1 if not. Caches the saved value in __BUILD_HAS_TTY to avoid running the test each call.ZL'$'\n''See: stty /dev/tty'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Environment: - __BUILD_HAS_TTY - Cached value of false or true. Any other value forces computation during this call.'$'\n''Credits: Tim Perry'$'\n''URL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.464
