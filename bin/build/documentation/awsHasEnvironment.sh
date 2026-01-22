#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="This tests \`AWS_ACCESS_KEY_ID\` and \`AWS_SECRET_ACCESS_KEY\` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1."$'\n'"Fails if either \`AWS_ACCESS_KEY_ID\` or \`AWS_SECRET_ACCESS_KEY\` is blank"$'\n'""$'\n'"Return Code: 0 - If environment needs to be updated"$'\n'"Return Code: 1 - If the environment seems to be set already"$'\n'""$'\n'""
environment="AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)"$'\n'"AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)"$'\n'""
example="    if awsHasEnvironment; then"$'\n'"    ..."$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsHasEnvironment"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Test whether the AWS environment variables are set or not"$'\n'""
usage="awsHasEnvironment [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsHasEnvironment[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

This tests [38;2;0;255;0;48;2;0;0;0mAWS_ACCESS_KEY_ID[0m and [38;2;0;255;0;48;2;0;0;0mAWS_SECRET_ACCESS_KEY[0m and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.
Fails if either [38;2;0;255;0;48;2;0;0;0mAWS_ACCESS_KEY_ID[0m or [38;2;0;255;0;48;2;0;0;0mAWS_SECRET_ACCESS_KEY[0m is blank

Return Code: 0 - If environment needs to be updated
Return Code: 1 - If the environment seems to be set already

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)
- AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)
- 

Example:
    if awsHasEnvironment; then
    ...
    fi
'
# shellcheck disable=SC2016
helpPlain='Usage: awsHasEnvironment [ --help ]

    --help  Flag. Optional. Display this help.

This tests AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.
Fails if either AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is blank

Return Code: 0 - If environment needs to be updated
Return Code: 1 - If the environment seems to be set already

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)
- AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)
- 

Example:
    if awsHasEnvironment; then
    ...
    fi
'
