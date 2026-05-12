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
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleTrimWidth'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mwidth'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mwidth  '$'\e''[[(value)]mUnsignedInteger. Required. Width to maintain.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext   '$'\e''[[(value)]mString. Optional. Text to trim to a console width.'$'\e''[[(reset)]m'$'\n'''$'\n''Truncate console output width'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''String. Optional. Text to trim to a console width.'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''String. Console string trimmed to the width requested.'
# shellcheck disable=SC2016
helpPlain='Usage: consoleTrimWidth width [ text ]'$'\n'''$'\n''    width  UnsignedInteger. Required. Width to maintain.'$'\n''    text   String. Optional. Text to trim to a console width.'$'\n'''$'\n''Truncate console output width'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''String. Optional. Text to trim to a console width.'$'\n'''$'\n''Writes to stdout:'$'\n''String. Console string trimmed to the width requested.'
documentationPath="documentation/source/tools/text.md"
