#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'-b - Flag. Causes trailing blanks (spaces and tabs) to be ignored, and other strings of blanks to compare equal.\n-B - Flag. Causes chunks that include only blank lines to be ignored.\n-i - Flag. Ignores the case of letters.  E.g., "A" will compare equal to "a".\n-w - Flag. Ignores all blanks and tabs.\n-I pattern - String. Optional. Ignore lines which match extended regular expression `pattern`.\nsource - File. Required. File to compare to.\ntarget ... - File. Required. Target file to compare to. Additional files are compared to `source`.\n--help - Flag. Optional. Display this help.\n'
base="diff.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Are files identical?"
descriptionLineCount=""
file="bin/build/tools/diff.sh"
fn="filesAreIdentical"
fnMarker="filesareidentical"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="47"
rawComment=$'Summary: Are files identical?\nArgument: -b - Flag. Causes trailing blanks (spaces and tabs) to be ignored, and other strings of blanks to compare equal.\nArgument: -B - Flag. Causes chunks that include only blank lines to be ignored.\nArgument: -i - Flag. Ignores the case of letters.  E.g., "A" will compare equal to "a".\nArgument: -w - Flag. Ignores all blanks and tabs.\nArgument: -I pattern - String. Optional. Ignore lines which match extended regular expression `pattern`.\nArgument: source - File. Required. File to compare to.\nArgument: target ... - File. Required. Target file to compare to. Additional files are compared to `source`.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - Files are identical\nReturn Code: 1 - Files differ\nReturn Code: 2 - Argument error\n\n'
return_code=$'0 - Files are identical\n1 - Files differ\n2 - Argument error\n'
sourceFile="bin/build/tools/diff.sh"
sourceHash="5bd24ee67b35642dc7b13c2b36f2800f3b45750c"
sourceLine="47"
summary="Are files identical?"
summaryComputed=""
usage="filesAreIdentical [ -b ] [ -B ] [ -i ] [ -w ] [ -I pattern ] source target ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfilesAreIdentical'$'\e''[0m '$'\e''[[(blue)]m[ -b ]'$'\e''[0m '$'\e''[[(blue)]m[ -B ]'$'\e''[0m '$'\e''[[(blue)]m[ -i ]'$'\e''[0m '$'\e''[[(blue)]m[ -w ]'$'\e''[0m '$'\e''[[(blue)]m[ -I pattern ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtarget ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m-b          '$'\e''[[(value)]mFlag. Causes trailing blanks (spaces and tabs) to be ignored, and other strings of blanks to compare equal.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m-B          '$'\e''[[(value)]mFlag. Causes chunks that include only blank lines to be ignored.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m-i          '$'\e''[[(value)]mFlag. Ignores the case of letters.  E.g., "A" will compare equal to "a".'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m-w          '$'\e''[[(value)]mFlag. Ignores all blanks and tabs.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m-I pattern  '$'\e''[[(value)]mString. Optional. Ignore lines which match extended regular expression '$'\e''[[(code)]mpattern'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msource      '$'\e''[[(value)]mFile. Required. File to compare to.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtarget ...  '$'\e''[[(value)]mFile. Required. Target file to compare to. Additional files are compared to '$'\e''[[(code)]msource'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Are files identical?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Files are identical'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Files differ'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: filesAreIdentical [ -b ] [ -B ] [ -i ] [ -w ] [ -I pattern ] source target ... [ --help ]'$'\n'''$'\n''    -b          Flag. Causes trailing blanks (spaces and tabs) to be ignored, and other strings of blanks to compare equal.'$'\n''    -B          Flag. Causes chunks that include only blank lines to be ignored.'$'\n''    -i          Flag. Ignores the case of letters.  E.g., "A" will compare equal to "a".'$'\n''    -w          Flag. Ignores all blanks and tabs.'$'\n''    -I pattern  String. Optional. Ignore lines which match extended regular expression pattern.'$'\n''    source      File. Required. File to compare to.'$'\n''    target ...  File. Required. Target file to compare to. Additional files are compared to source.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Are files identical?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Files are identical'$'\n''- 1 - Files differ'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/diff.md"
