#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="region ... - String. Required. The AWS Region to validate."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
checked="2024-09-02"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/aws.sh"
fn="awsRegionValid"
fnMarker="awsregionvalid"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="checked")
line="328"
rawComment="Summary: Check an AWS region code for validity"$'\n'"Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'"Argument: region ... - String. Required. The AWS Region to validate."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All regions are valid AWS region"$'\n'"Return Code: 1 - One or more regions are NOT a valid AWS region"$'\n'"Checked: 2024-09-02"$'\n'""$'\n'""
return_code="0 - All regions are valid AWS region"$'\n'"1 - One or more regions are NOT a valid AWS region"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="328"
summary="Check an AWS region code for validity"
summaryComputed=""
usage="awsRegionValid region ... [ --help ]"
