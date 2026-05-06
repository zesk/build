#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="haystack - String. Required. String to search."$'\n'"needle ... - String. Optional. One or more strings to find as a case-insensitive substring of \`haystack\`."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does needle exist as a substring of haystack?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringContainsInsensitive"
fnMarker="stringcontainsinsensitive"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
line="439"
rawComment="Argument: haystack - String. Required. String to search."$'\n'"Argument: needle ... - String. Optional. One or more strings to find as a case-insensitive substring of \`haystack\`."$'\n'"Return Code: 0 - IFF ANY needle matches as a substring of haystack"$'\n'"Return Code: 1 - No needles found in haystack"$'\n'"Summary: Find whether a substring exists in one or more strings"$'\n'"Does needle exist as a substring of haystack?"$'\n'""$'\n'""
return_code="0 - IFF ANY needle matches as a substring of haystack"$'\n'"1 - No needles found in haystack"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="439"
summary="Find whether a substring exists in one or more strings"
summaryComputed=""
usage="stringContainsInsensitive haystack [ needle ... ]"
