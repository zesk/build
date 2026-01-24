#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
credits="Tim Perry"$'\n'""
description="Returns 0 if a tty is available, 1 if not. Caches the saved value in \`__BUILD_HAS_TTY\` to avoid running the test each call.ZL"$'\n'""
environment="- \`__BUILD_HAS_TTY\` - Cached value of \`false\` or \`true\`. Any other value forces computation during this call."$'\n'""
exitCode="0"
file="bin/build/tools/colors.sh"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="environment" [4]="credits" [5]="url")
rawComment="Summary: Quiet test for a TTY"$'\n'"Returns 0 if a tty is available, 1 if not. Caches the saved value in \`__BUILD_HAS_TTY\` to avoid running the test each call.ZL"$'\n'"See: stty /dev/tty"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: - \`__BUILD_HAS_TTY\` - Cached value of \`false\` or \`true\`. Any other value forces computation during this call."$'\n'"Credits: Tim Perry"$'\n'"URL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty /dev/tty"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1769211509"
summary="Quiet test for a TTY"$'\n'""
url="https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional"$'\n'""
usage="isTTYAvailable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]misTTYAvailable'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Returns 0 if a tty is available, 1 if not. Caches the saved value in '$'\e''[[code]m__BUILD_HAS_TTY'$'\e''[[reset]m to avoid running the test each call.ZL'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[code]m__BUILD_HAS_TTY'$'\e''[[reset]m - Cached value of '$'\e''[[code]mfalse'$'\e''[[reset]m or '$'\e''[[code]mtrue'$'\e''[[reset]m. Any other value forces computation during this call.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isTTYAvailable [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Returns 0 if a tty is available, 1 if not. Caches the saved value in __BUILD_HAS_TTY to avoid running the test each call.ZL'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_HAS_TTY - Cached value of false or true. Any other value forces computation during this call.'$'\n'''
