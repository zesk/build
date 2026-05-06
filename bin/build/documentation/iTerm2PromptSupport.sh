#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add support for iTerm2 to bashPrompt"$'\n'"If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you"$'\n'"select it."$'\n'"It also reports the host, user and current directory back to iTerm2 on every prompt command."$'\n'""$'\n'""
descriptionLineCount="5"
environment="__ITERM2_HOST"$'\n'"__ITERM2_HOST_TIME"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2PromptSupport"
fnMarker="iterm2promptsupport"
foundNames=([0]="argument" [1]="see" [2]="requires" [3]="environment")
line="130"
rawComment="Add support for iTerm2 to bashPrompt"$'\n'"If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you"$'\n'"select it."$'\n'"It also reports the host, user and current directory back to iTerm2 on every prompt command."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: bashPrompt"$'\n'"Requires: catchEnvironment muzzle bashPrompt bashPromptMarkers iTerm2UpdateState"$'\n'"Requires: __iTerm2_mark __iTerm2_suffix __iTerm2UpdateState"$'\n'"Environment: __ITERM2_HOST"$'\n'"Environment: __ITERM2_HOST_TIME"$'\n'""$'\n'""
requires="catchEnvironment muzzle bashPrompt bashPromptMarkers iTerm2UpdateState"$'\n'"__iTerm2_mark __iTerm2_suffix __iTerm2UpdateState"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashPrompt"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="0527ba47f537e4e6b5039d1b56e7d23b8233bcae"
sourceLine="130"
summary="Add support for iTerm2 to bashPrompt"
summaryComputed="true"
usage="iTerm2PromptSupport [ --help ]"
