#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="needle - String. Required. Thing to search for, not blank."$'\n'"haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'""
base="text.sh"
description="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'""$'\n'"Return Code: 0 - If element is a substring of any haystack"$'\n'"Return Code: 1 - If element is NOT found as a substring of any haystack"$'\n'""$'\n'""
file="bin/build/tools/text.sh"
fn="isSubstring"
foundNames=([0]="argument" [1]="tested")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768759798"
summary="Check if one string is a substring of another set"
tested="No"$'\n'""
usage="isSubstring needle [ haystack ... ]"
