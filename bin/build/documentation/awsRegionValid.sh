#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="region ... - String. Required. The AWS Region to validate."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
checked="2024-09-02"$'\n'""
description="Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'""
exitCode="0"
file="bin/build/tools/aws.sh"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="checked")
rawComment="Summary: Check an AWS region code for validity"$'\n'"Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'"Argument: region ... - String. Required. The AWS Region to validate."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All regions are valid AWS region"$'\n'"Return Code: 1 - One or more regions are NOT a valid AWS region"$'\n'"Checked: 2024-09-02"$'\n'""$'\n'""
return_code="0 - All regions are valid AWS region"$'\n'"1 - One or more regions are NOT a valid AWS region"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1769185802"
summary="Check an AWS region code for validity"$'\n'""
usage="awsRegionValid region ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mawsRegionValid'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mregion ...'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mregion ...  '$'\e''[[value]mString. Required. The AWS Region to validate.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help      '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Checks an AWS region identifier for validity as of September 2024.'$'\n''Note that passing no parameters returns success.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - All regions are valid AWS region'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - One or more regions are NOT a valid AWS region'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsRegionValid region ... [ --help ]'$'\n'''$'\n''    region ...  String. Required. The AWS Region to validate.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Checks an AWS region identifier for validity as of September 2024.'$'\n''Note that passing no parameters returns success.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All regions are valid AWS region'$'\n''- 1 - One or more regions are NOT a valid AWS region'$'\n'''
