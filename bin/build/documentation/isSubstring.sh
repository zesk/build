#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="needle - String. Required. Thing to search for, not blank."$'\n'"haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'""
base="text.sh"
description="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="return_code" [2]="tested")
rawComment="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'"Argument: needle - String. Required. Thing to search for, not blank."$'\n'"Argument: haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'"Return Code: 0 - If element is a substring of any haystack"$'\n'"Return Code: 1 - If element is NOT found as a substring of any haystack"$'\n'"Tested: No"$'\n'""$'\n'""
return_code="0 - If element is a substring of any haystack"$'\n'"1 - If element is NOT found as a substring of any haystack"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Check if one string is a substring of another set"
summaryComputed="true"
tested="No"$'\n'""
usage="isSubstring needle [ haystack ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misSubstring'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mneedle'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ haystack ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mneedle        '$'\e''[[(value)]mString. Required. Thing to search for, not blank.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mhaystack ...  '$'\e''[[(value)]mEmptyString. Optional. One or more array elements to match'$'\e''[[(reset)]m'$'\n'''$'\n''Check if one string is a substring of another set of strings (case-sensitive)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If element is a substring of any haystack'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If element is NOT found as a substring of any haystack'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]misSubstring needle [[(blue)]m[ haystack ... ]'$'\n'''$'\n''    needle        String. Required. Thing to search for, not blank.'$'\n''    [[(blue)]mhaystack ...  EmptyString. Optional. One or more array elements to match'$'\n'''$'\n''Check if one string is a substring of another set of strings (case-sensitive)'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - If element is a substring of any haystack'$'\n''- [[(code)]m1 - If element is NOT found as a substring of any haystack'$'\n'''
# elapsed 3.455
