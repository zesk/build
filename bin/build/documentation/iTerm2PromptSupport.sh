#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'""
base="iterm2.sh"
description="Add support for iTerm2 to bashPrompt"$'\n'"If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you"$'\n'"select it."$'\n'"It also reports the host, user and current directory back to iTerm2 on every prompt command."$'\n'""$'\n'""
environment="__ITERM2_HOST"$'\n'"__ITERM2_HOST_TIME"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2PromptSupport"
foundNames=([0]="argument" [1]="see" [2]="requires" [3]="environment")
requires="catchEnvironment muzzle bashPrompt bashPromptMarkers iTerm2UpdateState"$'\n'"__iTerm2_mark __iTerm2_suffix __iTerm2UpdateState"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashPrompt"$'\n'""
source="bin/build/tools/iterm2.sh"
sourceModified="1768683751"
summary="Add support for iTerm2 to bashPrompt"
usage="iTerm2PromptSupport [ --help ]"
