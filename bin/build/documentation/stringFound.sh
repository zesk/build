#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="needle - String. Required. Thing to search for, not blank."$'\n'"haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'""
base="text.sh"
description="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'""
file="bin/build/tools/text.sh"
fn="stringFound"
foundNames=([0]="argument" [1]="return_code" [2]="tested")
line="469"
lowerFn="stringfound"
rawComment="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'"Argument: needle - String. Required. Thing to search for, not blank."$'\n'"Argument: haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'"Return Code: 0 - If element is a substring of any haystack"$'\n'"Return Code: 1 - If element is NOT found as a substring of any haystack"$'\n'"Tested: No"$'\n'""$'\n'""
return_code="0 - If element is a substring of any haystack"$'\n'"1 - If element is NOT found as a substring of any haystack"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="7f4afd0db4aa281d91724f7bdc480865ea6088e9"
sourceLine="469"
summary="Check if one string is a substring of another set"
summaryComputed="true"
tested="No"$'\n'""
usage="stringFound needle [ haystack ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringFound'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mneedle'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ haystack ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mneedle        '$'\e''[[(value)]mString. Required. Thing to search for, not blank.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mhaystack ...  '$'\e''[[(value)]mEmptyString. Optional. One or more array elements to match'$'\e''[[(reset)]m'$'\n'''$'\n''Check if one string is a substring of another set of strings (case-sensitive)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If element is a substring of any haystack'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If element is NOT found as a substring of any haystack'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: stringFound needle [ haystack ... ]'$'\n'''$'\n''    needle        String. Required. Thing to search for, not blank.'$'\n''    haystack ...  EmptyString. Optional. One or more array elements to match'$'\n'''$'\n''Check if one string is a substring of another set of strings (case-sensitive)'$'\n'''$'\n''Return codes:'$'\n''- 0 - If element is a substring of any haystack'$'\n''- 1 - If element is NOT found as a substring of any haystack'$'\n'''
documentationPath="documentation/source/tools/text.md"
