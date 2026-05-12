#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'width - UnsignedInteger. Required. Width to maintain.\ntext - String. Optional. Text to trim to a console width.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Truncate console output width"
descriptionLineCount=""
file="bin/build/tools/text.sh"
fn="consoleTrimWidth"
fnMarker="consoletrimwidth"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout")
line="955"
rawComment=$'Summary: Truncate console output width\nArgument: width - UnsignedInteger. Required. Width to maintain.\nArgument: text - String. Optional. Text to trim to a console width.\nstdin: String. Optional. Text to trim to a console width.\nstdout: String. Console string trimmed to the width requested.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="955"
stdin=$'String. Optional. Text to trim to a console width.\n'
stdout=$'String. Console string trimmed to the width requested.\n'
summary="Truncate console output width"
summaryComputed=""
usage="consoleTrimWidth width [ text ]"
