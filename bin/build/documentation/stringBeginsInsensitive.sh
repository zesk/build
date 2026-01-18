#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="haystack - String. Required. String to search. (case-insensitive)"$'\n'"needle ... - String. Optional. One or more strings to find as the \"start\" of \`haystack\` (case-insensitive)"$'\n'""
base="text.sh"
description="Return Code: 0 - IFF ANY needle matches as a substring of haystack (case-insensitive)"$'\n'"Return Code: 1 - No needles found in haystack (case-insensitive)"$'\n'"Does needle exist as a substring of haystack? (case-insensitive)"$'\n'""
file="bin/build/tools/text.sh"
fn="stringBeginsInsensitive"
foundNames=([0]="argument" [1]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768695708"
summary="Find whether a substring exists as teh beginning of one or more strings"$'\n'""
usage="stringBeginsInsensitive haystack [ needle ... ]"
