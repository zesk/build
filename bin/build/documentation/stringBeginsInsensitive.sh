#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="haystack - String. Required. String to search. (case-insensitive)"$'\n'"needle ... - String. Optional. One or more strings to find as the \"start\" of \`haystack\` (case-insensitive)"$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does needle exist as a substring of haystack? (case-insensitive)"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringBeginsInsensitive"
fnMarker="stringbeginsinsensitive"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
line="551"
rawComment="Argument: haystack - String. Required. String to search. (case-insensitive)"$'\n'"Argument: needle ... - String. Optional. One or more strings to find as the \"start\" of \`haystack\` (case-insensitive)"$'\n'"Return Code: 0 - IFF ANY needle matches as a substring of haystack (case-insensitive)"$'\n'"Return Code: 1 - No needles found in haystack (case-insensitive)"$'\n'"Summary: Find whether a substring exists as teh beginning of one or more strings"$'\n'"Does needle exist as a substring of haystack? (case-insensitive)"$'\n'""$'\n'""
return_code="0 - IFF ANY needle matches as a substring of haystack (case-insensitive)"$'\n'"1 - No needles found in haystack (case-insensitive)"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="551"
summary="Find whether a substring exists as teh beginning of one or more strings"
summaryComputed=""
usage="stringBeginsInsensitive haystack [ needle ... ]"
