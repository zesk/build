#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List AWS profiles available in the credentials file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/aws.sh"
fn="awsProfilesList"
fnMarker="awsprofileslist"
foundNames=([0]="argument" [1]="see")
line="135"
rawComment="List AWS profiles available in the credentials file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: awsCredentialsFile"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="awsCredentialsFile"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="135"
summary="List AWS profiles available in the credentials file"
summaryComputed="true"
usage="awsProfilesList [ --help ]"
