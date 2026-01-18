#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--profile profileName - String. Optional. The credentials profile to remove."$'\n'"--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"profileName - String. Optional. The credentials profile to remove."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="aws.sh"
description="Remove credentials from the AWS credentials file"$'\n'""$'\n'"If the AWS credentials file is not found, succeeds."$'\n'""$'\n'"You can supply the profile using the \`--profile\` or directly, but just one."$'\n'""$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsRemove"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768695708"
summary="Remove credentials from the AWS credentials file"
usage="awsCredentialsRemove [ --profile profileName ] [ --comments ] [ profileName ] [ --help ]"
