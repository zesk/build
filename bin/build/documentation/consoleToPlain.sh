#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="None."$'\n'""
base="text.sh"
credits="commandlinefu tripleee"$'\n'""
depends="sed"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Strip ANSI console escape sequences from a file"$'\n'""$'\n'""
descriptionLineCount="2"
environment="None."$'\n'""
file="bin/build/tools/text.sh"
fn="consoleToPlain"
fnMarker="consoletoplain"
foundNames=([0]="argument" [1]="environment" [2]="write_environment" [3]="credits" [4]="short_description" [5]="source" [6]="depends" [7]="stdin" [8]="stdout")
line="915"
rawComment="Strip ANSI console escape sequences from a file"$'\n'"Argument: None."$'\n'"Environment: None."$'\n'"Write Environment: None."$'\n'"Credits: commandlinefu tripleee"$'\n'"Short description: Remove ANSI escape codes from streams"$'\n'"Source: https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc"$'\n'"Depends: sed"$'\n'"stdin: arbitrary text which may contain ANSI escape sequences for the terminal"$'\n'"stdout: the same text with those ANSI escape sequences removed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
short_description="Remove ANSI escape codes from streams"$'\n'""
source="https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="915"
stdin="arbitrary text which may contain ANSI escape sequences for the terminal"$'\n'""
stdout="the same text with those ANSI escape sequences removed"$'\n'""
summary="Strip ANSI console escape sequences from a file"
summaryComputed="true"
usage="consoleToPlain [ None. ]"
write_environment="None."$'\n'""
