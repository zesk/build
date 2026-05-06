#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="keyDate - Date. Required. Formatted like \`YYYY-MM-DD\`. Truncated at 10 characters as well."$'\n'"upToDateDays - Integer. Optional. Days that key expires after \`keyDate\`. Default is 90."$'\n'"--name name - String. Optional. Name of the expiring item for error messages."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="stdout: Two tokens on a single line:"$'\n'""$'\n'"This tool checks the \`keyDate\` and checks if it is within \`days\` of today; if not this fails."$'\n'""$'\n'"It will also fail if:"$'\n'""$'\n'"- \`keyDate\` is empty or has an invalid value"$'\n'"- \`upToDateDays\` is less than zero"$'\n'""$'\n'""
descriptionLineCount="9"
example="    if ! dateWithinDays \"\$AWS_ACCESS_KEY_DATE\" 90; then"$'\n'"      decorate big Failed, update key and reset date"$'\n'"      exit 99"$'\n'"    fi"$'\n'""
file="bin/build/tools/date.sh"
fn="dateWithinDays"
fnMarker="datewithindays"
foundNames=([0]="summary" [1]="stdout" [2]="return_code" [3]="argument" [4]="example")
line="271"
rawComment="Summary: Is a date in the past beyond its expiration date?"$'\n'"stdout: Two tokens on a single line:"$'\n'"stdout: - UnsignedInteger. Days until expiration."$'\n'"stdout: - UnsignedInteger. Expiration timestamp."$'\n'"This tool checks the \`keyDate\` and checks if it is within \`days\` of today; if not this fails."$'\n'"It will also fail if:"$'\n'"- \`keyDate\` is empty or has an invalid value"$'\n'"- \`upToDateDays\` is less than zero"$'\n'"Return code: 0 - The date has not expired."$'\n'"Return code: 1 - The date has expired."$'\n'"Return code: 2 - The date is incorrectly formatted."$'\n'"Return code: 2 - Argument error."$'\n'"Argument: keyDate - Date. Required. Formatted like \`YYYY-MM-DD\`. Truncated at 10 characters as well."$'\n'"Argument: upToDateDays - Integer. Optional. Days that key expires after \`keyDate\`. Default is 90."$'\n'"Argument: --name name - String. Optional. Name of the expiring item for error messages."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     if ! dateWithinDays \"\$AWS_ACCESS_KEY_DATE\" 90; then"$'\n'"Example:       decorate big Failed, update key and reset date"$'\n'"Example:       exit 99"$'\n'"Example:     fi"$'\n'""$'\n'""
return_code="0 - The date has not expired."$'\n'"1 - The date has expired."$'\n'"2 - The date is incorrectly formatted."$'\n'"2 - Argument error."$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="271"
stdout="- UnsignedInteger. Days until expiration."$'\n'"- UnsignedInteger. Expiration timestamp."$'\n'""
summary="Is a date in the past beyond its expiration date?"
summaryComputed=""
usage="dateWithinDays keyDate [ upToDateDays ] [ --name name ] [ --help ]"
