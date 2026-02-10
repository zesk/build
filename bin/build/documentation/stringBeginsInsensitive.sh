#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="haystack - String. Required. String to search. (case-insensitive)"$'\n'"needle ... - String. Optional. One or more strings to find as the \"start\" of \`haystack\` (case-insensitive)"$'\n'""
base="text.sh"
description="Does needle exist as a substring of haystack? (case-insensitive)"$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
rawComment="Argument: haystack - String. Required. String to search. (case-insensitive)"$'\n'"Argument: needle ... - String. Optional. One or more strings to find as the \"start\" of \`haystack\` (case-insensitive)"$'\n'"Return Code: 0 - IFF ANY needle matches as a substring of haystack (case-insensitive)"$'\n'"Return Code: 1 - No needles found in haystack (case-insensitive)"$'\n'"Summary: Find whether a substring exists as teh beginning of one or more strings"$'\n'"Does needle exist as a substring of haystack? (case-insensitive)"$'\n'""$'\n'""
return_code="0 - IFF ANY needle matches as a substring of haystack (case-insensitive)"$'\n'"1 - No needles found in haystack (case-insensitive)"$'\n'""
sourceHash="1423839f48f30fd3607aa05d3ee0b5914066e4ba"
summary="Find whether a substring exists as teh beginning of one or more strings"$'\n'""
usage="stringBeginsInsensitive haystack [ needle ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringBeginsInsensitive'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhaystack'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ needle ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhaystack    '$'\e''[[(value)]mString. Required. String to search. (case-insensitive)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mneedle ...  '$'\e''[[(value)]mString. Optional. One or more strings to find as the "start" of '$'\e''[[(code)]mhaystack'$'\e''[[(reset)]m (case-insensitive)'$'\e''[[(reset)]m'$'\n'''$'\n''Does needle exist as a substring of haystack? (case-insensitive)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - IFF ANY needle matches as a substring of haystack (case-insensitive)'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No needles found in haystack (case-insensitive)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: stringBeginsInsensitive haystack [ needle ... ]'$'\n'''$'\n''    haystack    String. Required. String to search. (case-insensitive)'$'\n''    needle ...  String. Optional. One or more strings to find as the "start" of haystack (case-insensitive)'$'\n'''$'\n''Does needle exist as a substring of haystack? (case-insensitive)'$'\n'''$'\n''Return codes:'$'\n''- 0 - IFF ANY needle matches as a substring of haystack (case-insensitive)'$'\n''- 1 - No needles found in haystack (case-insensitive)'$'\n'''
