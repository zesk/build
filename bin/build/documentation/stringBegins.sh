#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Argument: haystack - String. Required. String to search."$'\n'"Argument: needle ... - String. Optional. One or more strings to find as the \"start\" of \`haystack\`."$'\n'"Return Code: 0 - IFF ANY needle matches as a substring of haystack"$'\n'"Return Code: 1 - No needles found in haystack"$'\n'"Summary: Find whether a substring exists as teh beginning of one or more strings"$'\n'"Does needle exist as a substring of haystack?"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Argument: haystack - String. Required. String to search."$'\n'"Argument: needle ... - String. Optional. One or more strings to find as the \"start\" of \`haystack\`."$'\n'"Return Code: 0 - IFF ANY needle matches as a substring of haystack"$'\n'"Return Code: 1 - No needles found in haystack"$'\n'"Summary: Find whether a substring exists as teh beginning of one or more strings"$'\n'"Does needle exist as a substring of haystack?"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Argument: haystack - String. Required. String to search."
usage="stringBegins"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringBegins'$'\e''[0m'$'\n'''$'\n''Argument: haystack - String. Required. String to search.'$'\n''Argument: needle ... - String. Optional. One or more strings to find as the "start" of '$'\e''[[(code)]mhaystack'$'\e''[[(reset)]m.'$'\n''Return Code: 0 - IFF ANY needle matches as a substring of haystack'$'\n''Return Code: 1 - No needles found in haystack'$'\n''Summary: Find whether a substring exists as teh beginning of one or more strings'$'\n''Does needle exist as a substring of haystack?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: stringBegins'$'\n'''$'\n''Argument: haystack - String. Required. String to search.'$'\n''Argument: needle ... - String. Optional. One or more strings to find as the "start" of haystack.'$'\n''Return Code: 0 - IFF ANY needle matches as a substring of haystack'$'\n''Return Code: 1 - No needles found in haystack'$'\n''Summary: Find whether a substring exists as teh beginning of one or more strings'$'\n''Does needle exist as a substring of haystack?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.502
