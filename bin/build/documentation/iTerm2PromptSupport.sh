#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="iterm2.sh"
description="Add support for iTerm2 to bashPrompt"$'\n'"If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you"$'\n'"select it."$'\n'"It also reports the host, user and current directory back to iTerm2 on every prompt command."$'\n'""
environment="__ITERM2_HOST"$'\n'"__ITERM2_HOST_TIME"$'\n'""
file="bin/build/tools/iterm2.sh"
foundNames=([0]="argument" [1]="see" [2]="requires" [3]="environment")
rawComment="Add support for iTerm2 to bashPrompt"$'\n'"If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you"$'\n'"select it."$'\n'"It also reports the host, user and current directory back to iTerm2 on every prompt command."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: bashPrompt"$'\n'"Requires: catchEnvironment muzzle bashPrompt bashPromptMarkers iTerm2UpdateState"$'\n'"Requires: __iTerm2_mark __iTerm2_suffix __iTerm2UpdateState"$'\n'"Environment: __ITERM2_HOST"$'\n'"Environment: __ITERM2_HOST_TIME"$'\n'""$'\n'""
requires="catchEnvironment muzzle bashPrompt bashPromptMarkers iTerm2UpdateState"$'\n'"__iTerm2_mark __iTerm2_suffix __iTerm2UpdateState"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashPrompt"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="b59a38e93b87dfec07eac18e712111781b8a471f"
summary="Add support for iTerm2 to bashPrompt"
summaryComputed="true"
usage="iTerm2PromptSupport [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2PromptSupport'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Add support for iTerm2 to bashPrompt'$'\n''If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you'$'\n''select it.'$'\n''It also reports the host, user and current directory back to iTerm2 on every prompt command.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __ITERM2_HOST'$'\n''- __ITERM2_HOST_TIME'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]miTerm2PromptSupport [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Add support for iTerm2 to bashPrompt'$'\n''If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you'$'\n''select it.'$'\n''It also reports the host, user and current directory back to iTerm2 on every prompt command.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __ITERM2_HOST'$'\n''- __ITERM2_HOST_TIME'$'\n'''
# elapsed 3.833
