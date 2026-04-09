#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="region ... - String. Required. The AWS Region to validate."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
checked="2024-09-02"$'\n'""
description="Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'""
file="bin/build/tools/aws.sh"
fn="awsRegionValid"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="checked")
line="328"
lowerFn="awsregionvalid"
rawComment="Summary: Check an AWS region code for validity"$'\n'"Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'"Argument: region ... - String. Required. The AWS Region to validate."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All regions are valid AWS region"$'\n'"Return Code: 1 - One or more regions are NOT a valid AWS region"$'\n'"Checked: 2024-09-02"$'\n'""$'\n'""
return_code="0 - All regions are valid AWS region"$'\n'"1 - One or more regions are NOT a valid AWS region"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="16fc69e4b0e8bc369cc44854fd5c323db626923a"
sourceLine="328"
summary="Check an AWS region code for validity"$'\n'""
usage="awsRegionValid region ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsRegionValid'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mregion ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mregion ...  '$'\e''[[(value)]mString. Required. The AWS Region to validate.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Checks an AWS region identifier for validity as of September 2024.'$'\n''Note that passing no parameters returns success.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All regions are valid AWS region'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more regions are NOT a valid AWS region'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsRegionValid region ... [ --help ]'$'\n'''$'\n''    region ...  String. Required. The AWS Region to validate.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Checks an AWS region identifier for validity as of September 2024.'$'\n''Note that passing no parameters returns success.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All regions are valid AWS region'$'\n''- 1 - One or more regions are NOT a valid AWS region'$'\n'''
documentationPath="documentation/source/tools/aws.md"
