#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'haystack - String. Required. String to search.\nneedle ... - String. Optional. One or more strings to find as a case-insensitive substring of `haystack`.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Does needle exist as a substring of haystack?\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringContainsInsensitive"
fnMarker="stringcontainsinsensitive"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
line="443"
rawComment=$'Argument: haystack - String. Required. String to search.\nArgument: needle ... - String. Optional. One or more strings to find as a case-insensitive substring of `haystack`.\nReturn Code: 0 - IFF ANY needle matches as a substring of haystack\nReturn Code: 1 - No needles found in haystack\nSummary: Find whether a substring exists in one or more strings\nDoes needle exist as a substring of haystack?\n\n'
return_code=$'0 - IFF ANY needle matches as a substring of haystack\n1 - No needles found in haystack\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="6d769d6727070a6dc8632961d7250fe1f73eea0f"
sourceLine="443"
summary="Find whether a substring exists in one or more strings"
summaryComputed=""
usage="stringContainsInsensitive haystack [ needle ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringContainsInsensitive'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhaystack'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ needle ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhaystack    '$'\e''[[(value)]mString. Required. String to search.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mneedle ...  '$'\e''[[(value)]mString. Optional. One or more strings to find as a case-insensitive substring of '$'\e''[[(code)]mhaystack'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Does needle exist as a substring of haystack?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - IFF ANY needle matches as a substring of haystack'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No needles found in haystack'
# shellcheck disable=SC2016
helpPlain='Usage: stringContainsInsensitive haystack [ needle ... ]'$'\n'''$'\n''    haystack    String. Required. String to search.'$'\n''    needle ...  String. Optional. One or more strings to find as a case-insensitive substring of haystack.'$'\n'''$'\n''Does needle exist as a substring of haystack?'$'\n'''$'\n''Return codes:'$'\n''- 0 - IFF ANY needle matches as a substring of haystack'$'\n''- 1 - No needles found in haystack'
documentationPath="documentation/source/tools/text.md"
