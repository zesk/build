#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="region ... - String. Required. The AWS Region to validate."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
checked="2024-09-02"$'\n'""
description="Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'"Return Code: 0 - All regions are valid AWS region"$'\n'"Return Code: 1 - One or more regions are NOT a valid AWS region"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsRegionValid"
foundNames=([0]="summary" [1]="argument" [2]="checked")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768721469"
summary="Check an AWS region code for validity"$'\n'""
usage="awsRegionValid region ... [ --help ]"
