#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="upToDateDays - PositiveInteger."$'\n'""
base="aws.sh"
description="For security we gotta update our keys every 90 days"$'\n'""$'\n'"This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers"$'\n'"can not just update the value to avoid the security issue."$'\n'""$'\n'"This tool checks the environment \`AWS_ACCESS_KEY_DATE\` and ensures it's within \`upToDateDays\` of today; if not this fails."$'\n'""$'\n'"It will also fail if:"$'\n'""$'\n'"- \`upToDateDays\` is less than zero or greater than 366"$'\n'"- \`AWS_ACCESS_KEY_DATE\` is empty or has an invalid value"$'\n'""$'\n'"Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the \`AWS_ACCESS_KEY_DATE\` has not exceeded the number of days."$'\n'""$'\n'""$'\n'""
environment="AWS_ACCESS_KEY_DATE - Variable used to test"$'\n'"AWS_ACCESS_KEY_DATE - Read-only. Date. A \`YYYY-MM-DD\` formatted date which represents the date that the key was generated."$'\n'""
example="    if ! awsIsKeyUpToDate 90; then"$'\n'"        bigText Failed, update key and reset date"$'\n'"        exit 99"$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsIsKeyUpToDate"
foundNames=([0]="environment" [1]="summary" [2]="argument" [3]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Test whether the AWS keys do not need to be updated"$'\n'""
usage="awsIsKeyUpToDate [ upToDateDays ]"
