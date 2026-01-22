#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/pipeline.sh"
argument="keyDate - Date. Required. Formatted like \`YYYY-MM-DD\`. Truncated at 10 characters as well."$'\n'"upToDateDays - Integer. Required. Days that key expires after \`keyDate\`."$'\n'"--name name - String. Optional. Name of the expiring item for error messages."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="pipeline.sh"
description="For security one should update keys every N days"$'\n'""$'\n'"This value would be better encrypted and tied to the key itself so developers"$'\n'"can not just update the value to avoid the security issue."$'\n'""$'\n'"This tool checks the value and checks if it is \`upToDateDays\` of today; if not this fails."$'\n'""$'\n'"It will also fail if:"$'\n'""$'\n'"- \`upToDateDays\` is less than zero or greater than 366"$'\n'"- \`keyDate\` is empty or has an invalid value"$'\n'""$'\n'"Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the \`keyDate\` has not exceeded the number of days."$'\n'""$'\n'""
example="    if !isUpToDate \"\$AWS_ACCESS_KEY_DATE\" 90; then"$'\n'"      bigText Failed, update key and reset date"$'\n'"      exit 99"$'\n'"    fi"$'\n'""
file="bin/build/tools/pipeline.sh"
fn="isUpToDate"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/pipeline.sh"
sourceModified="1769063211"
summary="Test whether the key needs to be updated"$'\n'""
usage="isUpToDate keyDate upToDateDays [ --name name ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misUpToDate[0m [38;2;255;255;0m[35;48;2;0;0;0mkeyDate[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mupToDateDays[0m[0m [94m[ --name name ][0m [94m[ --help ][0m

    [31mkeyDate       [1;97mDate. Required. Formatted like [38;2;0;255;0;48;2;0;0;0mYYYY-MM-DD[0m. Truncated at 10 characters as well.[0m
    [31mupToDateDays  [1;97mInteger. Required. Days that key expires after [38;2;0;255;0;48;2;0;0;0mkeyDate[0m.[0m
    [94m--name name   [1;97mString. Optional. Name of the expiring item for error messages.[0m
    [94m--help        [1;97mFlag. Optional. Display this help.[0m

For security one should update keys every N days

This value would be better encrypted and tied to the key itself so developers
can not just update the value to avoid the security issue.

This tool checks the value and checks if it is [38;2;0;255;0;48;2;0;0;0mupToDateDays[0m of today; if not this fails.

It will also fail if:

- [38;2;0;255;0;48;2;0;0;0mupToDateDays[0m is less than zero or greater than 366
- [38;2;0;255;0;48;2;0;0;0mkeyDate[0m is empty or has an invalid value

Otherwise, the tool [36mmay[0m output a message to the console warning of pending days, and returns exit code 0 if the [38;2;0;255;0;48;2;0;0;0mkeyDate[0m has not exceeded the number of days.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    if !isUpToDate "$AWS_ACCESS_KEY_DATE" 90; then
      bigText Failed, update key and reset date
      exit 99
    fi
'
# shellcheck disable=SC2016
helpPlain='Usage: isUpToDate keyDate upToDateDays [ --name name ] [ --help ]

    keyDate       Date. Required. Formatted like YYYY-MM-DD. Truncated at 10 characters as well.
    upToDateDays  Integer. Required. Days that key expires after keyDate.
    --name name   String. Optional. Name of the expiring item for error messages.
    --help        Flag. Optional. Display this help.

For security one should update keys every N days

This value would be better encrypted and tied to the key itself so developers
can not just update the value to avoid the security issue.

This tool checks the value and checks if it is upToDateDays of today; if not this fails.

It will also fail if:

- upToDateDays is less than zero or greater than 366
- keyDate is empty or has an invalid value

Otherwise, the tool may output a message to the console warning of pending days, and returns exit code 0 if the keyDate has not exceeded the number of days.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    if !isUpToDate "$AWS_ACCESS_KEY_DATE" 90; then
      bigText Failed, update key and reset date
      exit 99
    fi
'
