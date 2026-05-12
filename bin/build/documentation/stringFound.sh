#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'needle - String. Required. Thing to search for, not blank.\nhaystack ... - EmptyString. Optional. One or more array elements to match\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Check if one string is a substring of another set of strings (case-sensitive)\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringFound"
fnMarker="stringfound"
foundNames=([0]="argument" [1]="return_code" [2]="tested")
line="472"
rawComment=$'Check if one string is a substring of another set of strings (case-sensitive)\nArgument: needle - String. Required. Thing to search for, not blank.\nArgument: haystack ... - EmptyString. Optional. One or more array elements to match\nReturn Code: 0 - If element is a substring of any haystack\nReturn Code: 1 - If element is NOT found as a substring of any haystack\nTested: No\n\n'
return_code=$'0 - If element is a substring of any haystack\n1 - If element is NOT found as a substring of any haystack\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="472"
summary="Check if one string is a substring of another set"
summaryComputed="true"
tested=$'No\n'
usage="stringFound needle [ haystack ... ]"
