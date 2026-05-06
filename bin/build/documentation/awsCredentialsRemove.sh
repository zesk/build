#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--profile profileName - String. Optional. The credentials profile to remove."$'\n'"--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"profileName - String. Optional. The credentials profile to remove."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove credentials from the AWS credentials file"$'\n'""$'\n'"If the AWS credentials file is not found, succeeds."$'\n'""$'\n'"You can supply the profile using the \`--profile\` or directly, but just one."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/aws.sh"
fn="awsCredentialsRemove"
fnMarker="awscredentialsremove"
foundNames=([0]="argument")
line="234"
rawComment="Remove credentials from the AWS credentials file"$'\n'"If the AWS credentials file is not found, succeeds."$'\n'"You can supply the profile using the \`--profile\` or directly, but just one."$'\n'"Argument: --profile profileName - String. Optional. The credentials profile to remove."$'\n'"Argument: --comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"Argument: profileName - String. Optional. The credentials profile to remove."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="234"
summary="Remove credentials from the AWS credentials file"
summaryComputed="true"
usage="awsCredentialsRemove [ --profile profileName ] [ --comments ] [ profileName ] [ --help ]"
