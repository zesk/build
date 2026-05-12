#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'message - String. Required. Text to display.\n'
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Sends a notification message via Mac OS X from iTerm2\n\n'
descriptionLineCount="2"
file="bin/build/tools/iterm2.sh"
fn="iTerm2Notify"
fnMarker="iterm2notify"
foundNames=([0]="argument")
line="780"
rawComment=$'Sends a notification message via Mac OS X from iTerm2\nArgument: message - String. Required. Text to display.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="13698f5ecbedc059696bbffbebc13f8cf7096e44"
sourceLine="780"
summary="Sends a notification message via Mac OS X from iTerm2"
summaryComputed="true"
usage="iTerm2Notify message"
