#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="text - String. Required. Text to search for mapping tokens."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check if text contains plain text only (no ANSI escape codes, etc.)"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="isPlain"
fnMarker="isplain"
foundNames=([0]="argument" [1]="return_code")
line="90"
rawComment="Check if text contains plain text only (no ANSI escape codes, etc.)"$'\n'"Argument: text - String. Required. Text to search for mapping tokens."$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""$'\n'""
return_code="- \`0\` - Text is plain"$'\n'"- \`1\` - Text contains non-plain characters"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="90"
summary="Check if text contains plain text only (no ANSI escape"
summaryComputed="true"
usage="isPlain text"
