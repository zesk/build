#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="haystack - String. Required. String to search."$'\n'"needle ... - String. Optional. One or more strings to find as a substring of \`haystack\`."$'\n'""
base="text.sh"
description="Return Code: 0 - IFF ANY needle matches as a substring of haystack"$'\n'"Return Code: 1 - No needles found in haystack"$'\n'"Does needle exist as a substring of haystack?"$'\n'""
file="bin/build/tools/text.sh"
fn="stringContains"
foundNames=([0]="argument" [1]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768721469"
summary="Find whether a substring exists in one or more strings"$'\n'""
usage="stringContains haystack [ needle ... ]"
