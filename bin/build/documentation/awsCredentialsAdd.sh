#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--profile profileName - String. Optional. The credentials profile to write (default value is \`default\`)"$'\n'"--force - Flag. Optional. Write the credentials file even if the profile already exists"$'\n'"--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"--help - Flag. Optional. Display this help."$'\n'"key - The AWS_ACCESS_KEY_ID to write"$'\n'"secret - The AWS_SECRET_ACCESS_KEY to write"$'\n'""
base="aws.sh"
description="Write the credentials to the AWS credentials file."$'\n'""$'\n'"If the AWS credentials file is not found, it is created"$'\n'""$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsAdd"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Write an AWS profile to the AWS credentials file"$'\n'""
usage="awsCredentialsAdd [ --profile profileName ] [ --force ] [ --comments ] [ --help ] [ key ] [ secret ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsCredentialsAdd[0m [94m[ --profile profileName ][0m [94m[ --force ][0m [94m[ --comments ][0m [94m[ --help ][0m [94m[ key ][0m [94m[ secret ][0m

    [94m--profile profileName  [1;97mString. Optional. The credentials profile to write (default value is [38;2;0;255;0;48;2;0;0;0mdefault[0m)[0m
    [94m--force                [1;97mFlag. Optional. Write the credentials file even if the profile already exists[0m
    [94m--comments             [1;97mFlag. Optional. Write comments to the credentials file (in addition to updating the record).[0m
    [94m--help                 [1;97mFlag. Optional. Display this help.[0m
    [94mkey                    [1;97mThe AWS_ACCESS_KEY_ID to write[0m
    [94msecret                 [1;97mThe AWS_SECRET_ACCESS_KEY to write[0m

Write the credentials to the AWS credentials file.

If the AWS credentials file is not found, it is created

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsAdd [ --profile profileName ] [ --force ] [ --comments ] [ --help ] [ key ] [ secret ]

    --profile profileName  String. Optional. The credentials profile to write (default value is default)
    --force                Flag. Optional. Write the credentials file even if the profile already exists
    --comments             Flag. Optional. Write comments to the credentials file (in addition to updating the record).
    --help                 Flag. Optional. Display this help.
    key                    The AWS_ACCESS_KEY_ID to write
    secret                 The AWS_SECRET_ACCESS_KEY to write

Write the credentials to the AWS credentials file.

If the AWS credentials file is not found, it is created

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
