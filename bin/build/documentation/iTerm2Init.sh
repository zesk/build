#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
description="Add iTerm2 support to console"$'\n'""
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Init"
foundNames=([0]="argument" [1]="environment" [2]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="iTerm2Aliases iTerm2PromptSupport"$'\n'""
source="bin/build/tools/iterm2.sh"
sourceModified="1768759385"
summary="Add iTerm2 support to console"
usage="iTerm2Init [ --ignore | -i ]"
