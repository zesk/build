#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="-b - Flag. Causes trailing blanks (spaces and tabs) to be ignored, and other strings of blanks to compare equal."$'\n'"-B - Flag. Causes chunks that include only blank lines to be ignored."$'\n'"-i - Flag. Ignores the case of letters.  E.g., \"A\" will compare equal to \"a\"."$'\n'"-w - Flag. Ignores all blanks and tabs."$'\n'"-I pattern - String. Optional. Ignore lines which match extended regular expression \`pattern\`."$'\n'"source - File. Required. File to compare to."$'\n'"target ... - File. Required. Target file to compare to. Additional files are compared to \`source\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="diff.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Are files identical?"
descriptionLineCount=""
file="bin/build/tools/diff.sh"
fn="filesAreIdentical"
fnMarker="filesareidentical"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="47"
rawComment="Summary: Are files identical?"$'\n'"Argument: -b - Flag. Causes trailing blanks (spaces and tabs) to be ignored, and other strings of blanks to compare equal."$'\n'"Argument: -B - Flag. Causes chunks that include only blank lines to be ignored."$'\n'"Argument: -i - Flag. Ignores the case of letters.  E.g., \"A\" will compare equal to \"a\"."$'\n'"Argument: -w - Flag. Ignores all blanks and tabs."$'\n'"Argument: -I pattern - String. Optional. Ignore lines which match extended regular expression \`pattern\`."$'\n'"Argument: source - File. Required. File to compare to."$'\n'"Argument: target ... - File. Required. Target file to compare to. Additional files are compared to \`source\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Files are identical"$'\n'"Return Code: 1 - Files differ"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Files are identical"$'\n'"1 - Files differ"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/diff.sh"
sourceHash="5d23493f2badd97cf2ab4c1ad08db8aaedcaa952"
sourceLine="47"
summary="Are files identical?"
summaryComputed=""
usage="filesAreIdentical [ -b ] [ -B ] [ -i ] [ -w ] [ -I pattern ] source target ... [ --help ]"
