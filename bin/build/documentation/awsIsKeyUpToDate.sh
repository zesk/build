#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="upToDateDays - PositiveInteger."$'\n'""
base="aws.sh"
description="For security we gotta update our keys every 90 days"$'\n'""$'\n'"This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers"$'\n'"can not just update the value to avoid the security issue."$'\n'""$'\n'"This tool checks the environment \`AWS_ACCESS_KEY_DATE\` and ensures it's within \`upToDateDays\` of today; if not this fails."$'\n'""$'\n'"It will also fail if:"$'\n'""$'\n'"- \`upToDateDays\` is less than zero or greater than 366"$'\n'"- \`AWS_ACCESS_KEY_DATE\` is empty or has an invalid value"$'\n'""$'\n'"Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the \`AWS_ACCESS_KEY_DATE\` has not exceeded the number of days."$'\n'""$'\n'""$'\n'""
environment="AWS_ACCESS_KEY_DATE - Variable used to test"$'\n'"AWS_ACCESS_KEY_DATE - Read-only. Date. A \`YYYY-MM-DD\` formatted date which represents the date that the key was generated."$'\n'""
example="    if ! awsIsKeyUpToDate 90; then"$'\n'"        bigText Failed, update key and reset date"$'\n'"        exit 99"$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsIsKeyUpToDate"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Test whether the AWS keys do not need to be updated"$'\n'""
usage="awsIsKeyUpToDate [ upToDateDays ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsIsKeyUpToDate[0m [94m[ upToDateDays ][0m

    [94mupToDateDays  [1;97mPositiveInteger.[0m

For security we gotta update our keys every 90 days

This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers
can not just update the value to avoid the security issue.

This tool checks the environment [38;2;0;255;0;48;2;0;0;0mAWS_ACCESS_KEY_DATE[0m and ensures it'\''s within [38;2;0;255;0;48;2;0;0;0mupToDateDays[0m of today; if not this fails.

It will also fail if:

- [38;2;0;255;0;48;2;0;0;0mupToDateDays[0m is less than zero or greater than 366
- [38;2;0;255;0;48;2;0;0;0mAWS_ACCESS_KEY_DATE[0m is empty or has an invalid value

Otherwise, the tool [36mmay[0m output a message to the console warning of pending days, and returns exit code 0 if the [38;2;0;255;0;48;2;0;0;0mAWS_ACCESS_KEY_DATE[0m has not exceeded the number of days.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- AWS_ACCESS_KEY_DATE - Variable used to test
- AWS_ACCESS_KEY_DATE - Read-only. Date. A [38;2;0;255;0;48;2;0;0;0mYYYY-MM-DD[0m formatted date which represents the date that the key was generated.
- 

Example:
    if ! awsIsKeyUpToDate 90; then
        bigText Failed, update key and reset date
        exit 99
    fi
'
# shellcheck disable=SC2016
helpPlain='Usage: awsIsKeyUpToDate [ upToDateDays ]

    upToDateDays  PositiveInteger.

For security we gotta update our keys every 90 days

This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers
can not just update the value to avoid the security issue.

This tool checks the environment AWS_ACCESS_KEY_DATE and ensures it'\''s within upToDateDays of today; if not this fails.

It will also fail if:

- upToDateDays is less than zero or greater than 366
- AWS_ACCESS_KEY_DATE is empty or has an invalid value

Otherwise, the tool may output a message to the console warning of pending days, and returns exit code 0 if the AWS_ACCESS_KEY_DATE has not exceeded the number of days.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- AWS_ACCESS_KEY_DATE - Variable used to test
- AWS_ACCESS_KEY_DATE - Read-only. Date. A YYYY-MM-DD formatted date which represents the date that the key was generated.
- 

Example:
    if ! awsIsKeyUpToDate 90; then
        bigText Failed, update key and reset date
        exit 99
    fi
'
