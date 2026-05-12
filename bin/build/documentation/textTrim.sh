#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'""
base="text.sh"
credits="Chris F.A. Johnson (2008)"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Trim spaces and only spaces from arguments or a pipe"$'\n'""$'\n'""
descriptionLineCount="2"
example="    textTrim \"\$token\""$'\n'"    grep \"\$tokenPattern\" | textTrim > \"\$tokensFound\""$'\n'""
file="bin/build/tools/text.sh"
fn="textTrim"
fnMarker="texttrim"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="example" [4]="summary" [5]="source" [6]="credits")
line="355"
rawComment="Trim spaces and only spaces from arguments or a pipe"$'\n'"Argument: text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs trimmed lines"$'\n'"Example:     {fn} \"\$token\""$'\n'"Example:     grep \"\$tokenPattern\" | textTrim > \"\$tokensFound\""$'\n'"Summary: Trim whitespace of a bash argument"$'\n'"Source: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816"$'\n'"Credits: Chris F.A. Johnson (2008)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="355"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs trimmed lines"$'\n'""
summary="Trim whitespace of a bash argument"
summaryComputed=""
usage="textTrim [ text ]"
