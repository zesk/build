#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="region ... - String. Required. The AWS Region to validate."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
checked="2024-09-02"$'\n'""
description="Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'""
file="bin/build/tools/aws.sh"
fn="awsRegionValid"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="checked")
rawComment="Summary: Check an AWS region code for validity"$'\n'"Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'"Argument: region ... - String. Required. The AWS Region to validate."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All regions are valid AWS region"$'\n'"Return Code: 1 - One or more regions are NOT a valid AWS region"$'\n'"Checked: 2024-09-02"$'\n'""$'\n'""
return_code="0 - All regions are valid AWS region"$'\n'"1 - One or more regions are NOT a valid AWS region"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Check an AWS region code for validity"$'\n'""
usage="awsRegionValid region ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
