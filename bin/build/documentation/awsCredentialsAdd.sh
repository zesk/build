#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--profile profileName - String. Optional. The credentials profile to write (default value is \`default\`)"$'\n'"--force - Flag. Optional. Write the credentials file even if the profile already exists"$'\n'"--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"--help - Flag. Optional. Display this help."$'\n'"key - The AWS_ACCESS_KEY_ID to write"$'\n'"secret - The AWS_SECRET_ACCESS_KEY to write"$'\n'""
base="aws.sh"
description="Write the credentials to the AWS credentials file."$'\n'""$'\n'"If the AWS credentials file is not found, it is created"$'\n'""$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsAdd"
foundNames=([0]="summary" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768721469"
summary="Write an AWS profile to the AWS credentials file"$'\n'""
usage="awsCredentialsAdd [ --profile profileName ] [ --force ] [ --comments ] [ --help ] [ key ] [ secret ]"
