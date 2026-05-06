#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add iTerm2 support to console"$'\n'""$'\n'""
descriptionLineCount="2"
environment="LC_TERMINAL"$'\n'"TERM"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Init"
fnMarker="iterm2init"
foundNames=([0]="argument" [1]="environment" [2]="see")
line="829"
rawComment="Add iTerm2 support to console"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"Environment: LC_TERMINAL"$'\n'"Environment: TERM"$'\n'"See: iTerm2Aliases iTerm2PromptSupport"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="iTerm2Aliases iTerm2PromptSupport"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="0527ba47f537e4e6b5039d1b56e7d23b8233bcae"
sourceLine="829"
summary="Add iTerm2 support to console"
summaryComputed="true"
usage="iTerm2Init [ --ignore | -i ]"
