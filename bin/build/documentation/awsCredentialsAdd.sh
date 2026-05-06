#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--profile profileName - String. Optional. The credentials profile to write (default value is \`default\`)"$'\n'"--force - Flag. Optional. Write the credentials file even if the profile already exists"$'\n'"--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"--help - Flag. Optional. Display this help."$'\n'"key - The AWS_ACCESS_KEY_ID to write"$'\n'"secret - The AWS_SECRET_ACCESS_KEY to write"$'\n'""
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Write the credentials to the AWS credentials file."$'\n'""$'\n'"If the AWS credentials file is not found, it is created"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/aws.sh"
fn="awsCredentialsAdd"
fnMarker="awscredentialsadd"
foundNames=([0]="summary" [1]="argument")
line="215"
rawComment="Write the credentials to the AWS credentials file."$'\n'"If the AWS credentials file is not found, it is created"$'\n'"Summary: Write an AWS profile to the AWS credentials file"$'\n'"Argument: --profile profileName - String. Optional. The credentials profile to write (default value is \`default\`)"$'\n'"Argument: --force - Flag. Optional. Write the credentials file even if the profile already exists"$'\n'"Argument: --comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: key - The AWS_ACCESS_KEY_ID to write"$'\n'"Argument: secret - The AWS_SECRET_ACCESS_KEY to write"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="215"
summary="Write an AWS profile to the AWS credentials file"
summaryComputed=""
usage="awsCredentialsAdd [ --profile profileName ] [ --force ] [ --comments ] [ --help ] [ key ] [ secret ]"
