#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
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
line="469"
rawComment="Check if one string is a substring of another set of strings (case-sensitive)"$'\n'"Argument: needle - String. Required. Thing to search for, not blank."$'\n'"Argument: haystack ... - EmptyString. Optional. One or more array elements to match"$'\n'"Return Code: 0 - If element is a substring of any haystack"$'\n'"Return Code: 1 - If element is NOT found as a substring of any haystack"$'\n'"Tested: No"$'\n'""$'\n'""
return_code="0 - If element is a substring of any haystack"$'\n'"1 - If element is NOT found as a substring of any haystack"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="469"
summary="Check if one string is a substring of another set"
summaryComputed="true"
tested="No"$'\n'""
usage="stringFound needle [ haystack ... ]"
