#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"text - String. Required. Text to replace."$'\n'"replace - String. Optional. Replacement string for newlines. Default is \`␤\`"$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Hide newlines in text (to ensure single-line output or other manipulation)"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="stringHideNewlines"
fnMarker="stringhidenewlines"
foundNames=([0]="summary" [1]="argument" [2]="stdout")
line="181"
rawComment="Hide newlines in text (to ensure single-line output or other manipulation)"$'\n'"Summary: Replace newlines in text with a replacement token for single-line output"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: text - String. Required. Text to replace."$'\n'"Argument: replace - String. Optional. Replacement string for newlines. Default is \`␤\`"$'\n'"Without arguments, displays help."$'\n'"stdout: The text with the newline replaced with another character, suitable typically for single-line output"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="181"
stdout="The text with the newline replaced with another character, suitable typically for single-line output"$'\n'""
summary="Replace newlines in text with a replacement token for single-line output"
summaryComputed=""
usage="stringHideNewlines [ --help ] text [ replace ]"
