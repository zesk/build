#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\n'
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Add iTerm2 support to console\n\n'
descriptionLineCount="2"
environment=$'LC_TERMINAL\nTERM\n'
file="bin/build/tools/iterm2.sh"
fn="iTerm2Init"
fnMarker="iterm2init"
foundNames=([0]="argument" [1]="environment" [2]="see")
line="834"
rawComment=$'Add iTerm2 support to console\nArgument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\nEnvironment: LC_TERMINAL\nEnvironment: TERM\nSee: iTerm2Aliases iTerm2PromptSupport\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'iTerm2Aliases iTerm2PromptSupport\n'
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="58eeb81a4d81f00507a1a74ca99c3238d4499cb1"
sourceLine="834"
summary="Add iTerm2 support to console"
summaryComputed="true"
usage="iTerm2Init [ --ignore | -i ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Init'$'\e''[0m '$'\e''[[(blue)]m[ --ignore | -i ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--ignore | -i  '$'\e''[[(value)]mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\e''[[(reset)]m'$'\n'''$'\n''Add iTerm2 support to console'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Init [ --ignore | -i ]'$'\n'''$'\n''    --ignore | -i  Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n'''$'\n''Add iTerm2 support to console'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- LC_TERMINAL'$'\n''- TERM'
documentationPath="documentation/source/tools/iterm2.md"
