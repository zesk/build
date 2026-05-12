#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\ntext - String. Required. Text to replace.\nreplace - String. Optional. Replacement string for newlines. Default is `␤`\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Hide newlines in text (to ensure single-line output or other manipulation)\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="stringHideNewlines"
fnMarker="stringhidenewlines"
foundNames=([0]="summary" [1]="argument" [2]="stdout")
line="181"
rawComment=$'Hide newlines in text (to ensure single-line output or other manipulation)\nSummary: Replace newlines in text with a replacement token for single-line output\nArgument: --help - Flag. Optional. Display this help.\nArgument: text - String. Required. Text to replace.\nArgument: replace - String. Optional. Replacement string for newlines. Default is `␤`\nWithout arguments, displays help.\nstdout: The text with the newline replaced with another character, suitable typically for single-line output\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="181"
stdout=$'The text with the newline replaced with another character, suitable typically for single-line output\n'
summary="Replace newlines in text with a replacement token for single-line output"
summaryComputed=""
usage="stringHideNewlines [ --help ] text [ replace ]"
