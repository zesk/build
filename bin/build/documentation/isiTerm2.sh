#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="iterm2.sh"
description="Is the current console iTerm2?"$'\n'"Succeeds when LC_TERMINAL is \`iTerm2\` AND TERM is NOT \`screen\`"$'\n'""
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="isiTerm2"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/iterm2.sh"
sourceModified="1768759385"
summary="Is the current console iTerm2?"
usage="isiTerm2 [ --help ]"
