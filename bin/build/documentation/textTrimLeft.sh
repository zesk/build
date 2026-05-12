#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Trim spaces and only spaces from the left side of a string passed as arguments or a pipe"$'\n'""$'\n'""
descriptionLineCount="2"
example="    textTrimLeft \"\$token\""$'\n'"    grep \"\$tokenPattern\" | textTrimLeft > \"\$tokensFound\""$'\n'""
file="bin/build/tools/text.sh"
fn="textTrimLeft"
fnMarker="texttrimleft"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="example" [4]="summary")
line="324"
rawComment="Trim spaces and only spaces from the left side of a string passed as arguments or a pipe"$'\n'"Argument: text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs trimmed lines"$'\n'"Example:     {fn} \"\$token\""$'\n'"Example:     grep \"\$tokenPattern\" | {fn} > \"\$tokensFound\""$'\n'"Summary: Trim whitespace of a bash argument"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="324"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs trimmed lines"$'\n'""
summary="Trim whitespace of a bash argument"
summaryComputed=""
usage="textTrimLeft [ text ]"
