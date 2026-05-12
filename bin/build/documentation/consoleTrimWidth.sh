#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="width - UnsignedInteger. Required. Width to maintain."$'\n'"text - String. Optional. Text to trim to a console width."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Truncate console output width"
descriptionLineCount=""
file="bin/build/tools/text.sh"
fn="consoleTrimWidth"
fnMarker="consoletrimwidth"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout")
line="951"
rawComment="Summary: Truncate console output width"$'\n'"Argument: width - UnsignedInteger. Required. Width to maintain."$'\n'"Argument: text - String. Optional. Text to trim to a console width."$'\n'"stdin: String. Optional. Text to trim to a console width."$'\n'"stdout: String. Console string trimmed to the width requested."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="951"
stdin="String. Optional. Text to trim to a console width."$'\n'""
stdout="String. Console string trimmed to the width requested."$'\n'""
summary="Truncate console output width"
summaryComputed=""
usage="consoleTrimWidth width [ text ]"
