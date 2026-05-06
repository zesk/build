#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
credits="Tim Perry"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Returns 0 if a tty is available, 1 if not. Caches the saved value in \`__BUILD_HAS_TTY\` to avoid running the test each call.ZL"$'\n'""$'\n'""
descriptionLineCount="2"
environment="- \`__BUILD_HAS_TTY\` - Cached value of \`false\` or \`true\`. Any other value forces computation during this call."$'\n'""
file="bin/build/tools/colors.sh"
fn="isTTYAvailable"
fnMarker="isttyavailable"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="environment" [4]="credits" [5]="url")
line="374"
rawComment="Summary: Quiet test for a TTY"$'\n'"Returns 0 if a tty is available, 1 if not. Caches the saved value in \`__BUILD_HAS_TTY\` to avoid running the test each call.ZL"$'\n'"See: stty /dev/tty"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: - \`__BUILD_HAS_TTY\` - Cached value of \`false\` or \`true\`. Any other value forces computation during this call."$'\n'"Credits: Tim Perry"$'\n'"URL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty /dev/tty"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="374"
summary="Quiet test for a TTY"
summaryComputed=""
url="https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional"$'\n'""
usage="isTTYAvailable [ --help ]"
