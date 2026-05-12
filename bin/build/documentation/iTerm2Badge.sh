#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\nmessage ... - String. Required. Any message to display as the badge\n'
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set the badge for the iTerm2 console\n\n'
descriptionLineCount="2"
environment=$'LC_TERMINAL\n'
file="bin/build/tools/iterm2.sh"
fn="iTerm2Badge"
fnMarker="iterm2badge"
foundNames=([0]="argument" [1]="environment")
line="663"
rawComment=$'Set the badge for the iTerm2 console\nArgument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\nArgument: message ... - String. Required. Any message to display as the badge\nEnvironment: LC_TERMINAL\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="13698f5ecbedc059696bbffbebc13f8cf7096e44"
sourceLine="663"
summary="Set the badge for the iTerm2 console"
summaryComputed="true"
usage="iTerm2Badge [ --ignore | -i ] message ..."
