#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="haystack - String. Required. String to search."$'\n'"needle ... - String. Optional. One or more strings to find as a case-insensitive substring of \`haystack\`."$'\n'""
base="text.sh"
description="Does needle exist as a substring of haystack?"$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
rawComment="Argument: haystack - String. Required. String to search."$'\n'"Argument: needle ... - String. Optional. One or more strings to find as a case-insensitive substring of \`haystack\`."$'\n'"Return Code: 0 - IFF ANY needle matches as a substring of haystack"$'\n'"Return Code: 1 - No needles found in haystack"$'\n'"Summary: Find whether a substring exists in one or more strings"$'\n'"Does needle exist as a substring of haystack?"$'\n'""$'\n'""
return_code="0 - IFF ANY needle matches as a substring of haystack"$'\n'"1 - No needles found in haystack"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Find whether a substring exists in one or more strings"$'\n'""
usage="stringContainsInsensitive haystack [ needle ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringContainsInsensitive'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhaystack'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ needle ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhaystack    '$'\e''[[(value)]mString. Required. String to search.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mneedle ...  '$'\e''[[(value)]mString. Optional. One or more strings to find as a case-insensitive substring of '$'\e''[[(code)]mhaystack'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Does needle exist as a substring of haystack?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - IFF ANY needle matches as a substring of haystack'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No needles found in haystack'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mstringContainsInsensitive [[(bold)]m[[(magenta)]mhaystack [[(blue)]m[ needle ... ]'$'\n'''$'\n''    [[(red)]mhaystack    [[(value)]mString. Required. String to search.'$'\n''    [[(blue)]mneedle ...  [[(value)]mString. Optional. One or more strings to find as a case-insensitive substring of [[(code)]mhaystack.'$'\n'''$'\n''Does needle exist as a substring of haystack?'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - IFF ANY needle matches as a substring of haystack'$'\n''- [[(code)]m1 - No needles found in haystack'$'\n'''
