#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'region ... - String. Required. The AWS Region to validate.\n--help - Flag. Optional. Display this help.\n'
base="aws.sh"
checked=$'2024-09-02\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Checks an AWS region identifier for validity as of September 2024.\nNote that passing no parameters returns success.\n\n'
descriptionLineCount="3"
file="bin/build/tools/aws.sh"
fn="awsRegionValid"
fnMarker="awsregionvalid"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="checked")
line="328"
rawComment=$'Summary: Check an AWS region code for validity\nChecks an AWS region identifier for validity as of September 2024.\nNote that passing no parameters returns success.\nArgument: region ... - String. Required. The AWS Region to validate.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - All regions are valid AWS region\nReturn Code: 1 - One or more regions are NOT a valid AWS region\nChecked: 2024-09-02\n\n'
return_code=$'0 - All regions are valid AWS region\n1 - One or more regions are NOT a valid AWS region\n'
sourceFile="bin/build/tools/aws.sh"
sourceHash="9d4ed3ead974a5078fada208dc2c1f1e7d157af7"
sourceLine="328"
summary="Check an AWS region code for validity"
summaryComputed=""
usage="awsRegionValid region ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsRegionValid'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mregion ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mregion ...  '$'\e''[[(value)]mString. Required. The AWS Region to validate.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Checks an AWS region identifier for validity as of September 2024.'$'\n''Note that passing no parameters returns success.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All regions are valid AWS region'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more regions are NOT a valid AWS region'
# shellcheck disable=SC2016
helpPlain='Usage: awsRegionValid region ... [ --help ]'$'\n'''$'\n''    region ...  String. Required. The AWS Region to validate.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Checks an AWS region identifier for validity as of September 2024.'$'\n''Note that passing no parameters returns success.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All regions are valid AWS region'$'\n''- 1 - One or more regions are NOT a valid AWS region'
documentationPath="documentation/source/tools/aws.md"
