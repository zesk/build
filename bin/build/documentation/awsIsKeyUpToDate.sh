#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="upToDateDays - PositiveInteger."$'\n'""
base="aws.sh"
description="For security we gotta update our keys every 90 days"$'\n'"This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers"$'\n'"can not just update the value to avoid the security issue."$'\n'"This tool checks the environment \`AWS_ACCESS_KEY_DATE\` and ensures it's within \`upToDateDays\` of today; if not this fails."$'\n'"It will also fail if:"$'\n'"- \`upToDateDays\` is less than zero or greater than 366"$'\n'"- \`AWS_ACCESS_KEY_DATE\` is empty or has an invalid value"$'\n'"Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the \`AWS_ACCESS_KEY_DATE\` has not exceeded the number of days."$'\n'""
environment="AWS_ACCESS_KEY_DATE - Variable used to test"$'\n'"AWS_ACCESS_KEY_DATE - Read-only. Date. A \`YYYY-MM-DD\` formatted date which represents the date that the key was generated."$'\n'""
example="    if ! awsIsKeyUpToDate 90; then"$'\n'"        bigText Failed, update key and reset date"$'\n'"        exit 99"$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsIsKeyUpToDate"
foundNames=([0]="environment" [1]="summary" [2]="argument" [3]="example")
rawComment="For security we gotta update our keys every 90 days"$'\n'"This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers"$'\n'"can not just update the value to avoid the security issue."$'\n'"This tool checks the environment \`AWS_ACCESS_KEY_DATE\` and ensures it's within \`upToDateDays\` of today; if not this fails."$'\n'"It will also fail if:"$'\n'"- \`upToDateDays\` is less than zero or greater than 366"$'\n'"- \`AWS_ACCESS_KEY_DATE\` is empty or has an invalid value"$'\n'"Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the \`AWS_ACCESS_KEY_DATE\` has not exceeded the number of days."$'\n'"Environment: AWS_ACCESS_KEY_DATE - Variable used to test"$'\n'"Summary: Test whether the AWS keys do not need to be updated"$'\n'"Argument: upToDateDays - PositiveInteger."$'\n'"Example:     if ! {fn} 90; then"$'\n'"Example:         bigText Failed, update key and reset date"$'\n'"Example:         exit 99"$'\n'"Example:     fi"$'\n'"Environment: AWS_ACCESS_KEY_DATE - Read-only. Date. A \`YYYY-MM-DD\` formatted date which represents the date that the key was generated."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Test whether the AWS keys do not need to be updated"$'\n'""
usage="awsIsKeyUpToDate [ upToDateDays ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
