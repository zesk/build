#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/pipeline.sh"
argument="keyDate - Date. Required. Formatted like \`YYYY-MM-DD\`. Truncated at 10 characters as well."$'\n'"upToDateDays - Integer. Required. Days that key expires after \`keyDate\`."$'\n'"--name name - String. Optional. Name of the expiring item for error messages."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="pipeline.sh"
description="For security one should update keys every N days"$'\n'""$'\n'"This value would be better encrypted and tied to the key itself so developers"$'\n'"can not just update the value to avoid the security issue."$'\n'""$'\n'"This tool checks the value and checks if it is \`upToDateDays\` of today; if not this fails."$'\n'""$'\n'"It will also fail if:"$'\n'""$'\n'"- \`upToDateDays\` is less than zero or greater than 366"$'\n'"- \`keyDate\` is empty or has an invalid value"$'\n'""$'\n'"Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the \`keyDate\` has not exceeded the number of days."$'\n'""$'\n'""
example="    if !isUpToDate \"\$AWS_ACCESS_KEY_DATE\" 90; then"$'\n'"      bigText Failed, update key and reset date"$'\n'"      exit 99"$'\n'"    fi"$'\n'""
file="bin/build/tools/pipeline.sh"
fn="isUpToDate"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/pipeline.sh"
sourceModified="1768759595"
summary="Test whether the key needs to be updated"$'\n'""
usage="isUpToDate keyDate upToDateDays [ --name name ] [ --help ]"
