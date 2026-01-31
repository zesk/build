#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'"Argument: needle - String. Required. Thing to search for, not blank."$'\n'"Argument: haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'"Return Code: 0 - If element is a substring of any haystack"$'\n'"Return Code: 1 - If element is NOT found as a substring of any haystack"$'\n'"Tested: No"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'"Argument: needle - String. Required. Thing to search for, not blank."$'\n'"Argument: haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'"Return Code: 0 - If element is a substring of any haystack"$'\n'"Return Code: 1 - If element is NOT found as a substring of any haystack"$'\n'"Tested: No"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Check if one string is a substring of another set"
usage="isSubstring"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misSubstring'$'\e''[0m'$'\n'''$'\n''Check if one string is a substring of another set of strings (case-sensitive)'$'\n''Argument: needle - String. Required. Thing to search for, not blank.'$'\n''Argument: haystack ... - EmptyString. Optional. One or more array elements to match'$'\n''Return Code: 0 - If element is a substring of any haystack'$'\n''Return Code: 1 - If element is NOT found as a substring of any haystack'$'\n''Tested: No'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isSubstring'$'\n'''$'\n''Check if one string is a substring of another set of strings (case-sensitive)'$'\n''Argument: needle - String. Required. Thing to search for, not blank.'$'\n''Argument: haystack ... - EmptyString. Optional. One or more array elements to match'$'\n''Return Code: 0 - If element is a substring of any haystack'$'\n''Return Code: 1 - If element is NOT found as a substring of any haystack'$'\n''Tested: No'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.49
