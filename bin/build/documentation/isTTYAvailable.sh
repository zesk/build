#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
credits="Tim Perry"$'\n'""
description="Returns 0 if a tty is available, 1 if not. Caches the saved value in \`__BUILD_HAS_TTY\` to avoid running the test each call.ZL"$'\n'""
environment="- \`__BUILD_HAS_TTY\` - Cached value of \`false\` or \`true\`. Any other value forces computation during this call."$'\n'""
file="bin/build/tools/colors.sh"
fn="isTTYAvailable"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="environment" [4]="credits" [5]="url")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty /dev/tty"$'\n'""
source="bin/build/tools/colors.sh"
sourceModified="1768757397"
summary="Quiet test for a TTY"$'\n'""
url="https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional"$'\n'""
usage="isTTYAvailable [ --help ]"
