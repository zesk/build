#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="value - EmptyString. Value to check."$'\n'""
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is the URL passed in a S3 URL?"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/aws.sh"
fn="isS3URL"
fnMarker="iss3url"
foundNames=([0]="argument")
line="373"
rawComment="Is the URL passed in a S3 URL?"$'\n'"Argument: value - EmptyString. Value to check."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="373"
summary="Is the URL passed in a S3 URL?"
summaryComputed="true"
usage="isS3URL [ value ]"
