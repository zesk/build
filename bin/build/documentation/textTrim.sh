#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.\n'
base="text.sh"
credits=$'Chris F.A. Johnson (2008)\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Trim spaces and only spaces from arguments or a pipe\n\n'
descriptionLineCount="2"
example=$'    textTrim "$token"\n    grep "$tokenPattern" | textTrim > "$tokensFound"\n'
file="bin/build/tools/text.sh"
fn="textTrim"
fnMarker="texttrim"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="example" [4]="summary" [5]="source" [6]="credits")
line="355"
rawComment=$'Trim spaces and only spaces from arguments or a pipe\nArgument: text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.\nstdin: Reads lines from stdin until EOF\nstdout: Outputs trimmed lines\nExample:     {fn} "$token"\nExample:     grep "$tokenPattern" | textTrim > "$tokensFound"\nSummary: Trim whitespace of a bash argument\nSource: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816\nCredits: Chris F.A. Johnson (2008)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
source=$'https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="355"
stdin=$'Reads lines from stdin until EOF\n'
stdout=$'Outputs trimmed lines\n'
summary="Trim whitespace of a bash argument"
summaryComputed=""
usage="textTrim [ text ]"
