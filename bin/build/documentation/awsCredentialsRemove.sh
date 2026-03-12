#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--profile profileName - String. Optional. The credentials profile to remove."$'\n'"--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"profileName - String. Optional. The credentials profile to remove."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="Remove credentials from the AWS credentials file"$'\n'"If the AWS credentials file is not found, succeeds."$'\n'"You can supply the profile using the \`--profile\` or directly, but just one."$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsRemove"
foundNames=([0]="argument")
rawComment="Remove credentials from the AWS credentials file"$'\n'"If the AWS credentials file is not found, succeeds."$'\n'"You can supply the profile using the \`--profile\` or directly, but just one."$'\n'"Argument: --profile profileName - String. Optional. The credentials profile to remove."$'\n'"Argument: --comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"Argument: profileName - String. Optional. The credentials profile to remove."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Remove credentials from the AWS credentials file"
summaryComputed="true"
usage="awsCredentialsRemove [ --profile profileName ] [ --comments ] [ profileName ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
