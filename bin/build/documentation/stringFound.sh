#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="needle - String. Required. Thing to search for, not blank."$'\n'"haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringFound"
fnMarker="stringfound"
foundNames=([0]="argument" [1]="return_code" [2]="tested")
line="473"
rawComment="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'"Argument: needle - String. Required. Thing to search for, not blank."$'\n'"Argument: haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'"Return Code: 0 - If element is a substring of any haystack"$'\n'"Return Code: 1 - If element is NOT found as a substring of any haystack"$'\n'"Tested: No"$'\n'""$'\n'""
return_code="0 - If element is a substring of any haystack"$'\n'"1 - If element is NOT found as a substring of any haystack"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="473"
summary="Check if one string is a substring of another set"
summaryComputed="true"
tested="No"$'\n'""
usage="stringFound needle [ haystack ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringFound'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mneedle'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ haystack ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mneedle        '$'\e''[[(value)]mString. Required. Thing to search for, not blank.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mhaystack ...  '$'\e''[[(value)]mEmptyString. Optional. One or more array elements to match'$'\e''[[(reset)]m'$'\n'''$'\n''Check if one string is a substring of another set of strings (case-sensitive)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If element is a substring of any haystack'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If element is NOT found as a substring of any haystack'
# shellcheck disable=SC2016
helpPlain='Usage: stringFound needle [ haystack ... ]'$'\n'''$'\n''    needle        String. Required. Thing to search for, not blank.'$'\n''    haystack ...  EmptyString. Optional. One or more array elements to match'$'\n'''$'\n''Check if one string is a substring of another set of strings (case-sensitive)'$'\n'''$'\n''Return codes:'$'\n''- 0 - If element is a substring of any haystack'$'\n''- 1 - If element is NOT found as a substring of any haystack'
documentationPath="documentation/source/tools/text.md"
