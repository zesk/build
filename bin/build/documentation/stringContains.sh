#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="haystack - String. Required. String to search."$'\n'"needle ... - String. Optional. One or more strings to find as a substring of \`haystack\`."$'\n'""
base="text.sh"
description="Does needle exist as a substring of haystack?"$'\n'""
file="bin/build/tools/text.sh"
fn="stringContains"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
line="414"
lowerFn="stringcontains"
rawComment="Argument: haystack - String. Required. String to search."$'\n'"Argument: needle ... - String. Optional. One or more strings to find as a substring of \`haystack\`."$'\n'"Return Code: 0 - IFF ANY needle matches as a substring of haystack"$'\n'"Return Code: 1 - No needles found in haystack"$'\n'"Summary: Find whether a substring exists in one or more strings"$'\n'"Does needle exist as a substring of haystack?"$'\n'""$'\n'""
return_code="0 - IFF ANY needle matches as a substring of haystack"$'\n'"1 - No needles found in haystack"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="7f4afd0db4aa281d91724f7bdc480865ea6088e9"
sourceLine="414"
summary="Find whether a substring exists in one or more strings"$'\n'""
usage="stringContains haystack [ needle ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringContains'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhaystack'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ needle ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhaystack    '$'\e''[[(value)]mString. Required. String to search.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mneedle ...  '$'\e''[[(value)]mString. Optional. One or more strings to find as a substring of '$'\e''[[(code)]mhaystack'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Does needle exist as a substring of haystack?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - IFF ANY needle matches as a substring of haystack'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No needles found in haystack'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: stringContains haystack [ needle ... ]'$'\n'''$'\n''    haystack    String. Required. String to search.'$'\n''    needle ...  String. Optional. One or more strings to find as a substring of haystack.'$'\n'''$'\n''Does needle exist as a substring of haystack?'$'\n'''$'\n''Return codes:'$'\n''- 0 - IFF ANY needle matches as a substring of haystack'$'\n''- 1 - No needles found in haystack'$'\n'''
documentationPath="documentation/source/tools/text.md"
