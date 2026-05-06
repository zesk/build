#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is the current console iTerm2?"$'\n'"Succeeds when LC_TERMINAL is \`iTerm2\` AND TERM is NOT \`screen\`"$'\n'""$'\n'""
descriptionLineCount="3"
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="isiTerm2"
fnMarker="isiterm2"
foundNames=([0]="argument" [1]="environment")
line="36"
rawComment="Is the current console iTerm2?"$'\n'"Succeeds when LC_TERMINAL is \`iTerm2\` AND TERM is NOT \`screen\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: LC_TERMINAL"$'\n'"Environment: TERM"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="0527ba47f537e4e6b5039d1b56e7d23b8233bcae"
sourceLine="36"
summary="Is the current console iTerm2?"
summaryComputed="true"
usage="isiTerm2 [ --help ]"
