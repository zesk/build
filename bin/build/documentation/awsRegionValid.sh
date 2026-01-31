#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="aws.sh"
description="Summary: Check an AWS region code for validity"$'\n'"Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'"Argument: region ... - String. Required. The AWS Region to validate."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All regions are valid AWS region"$'\n'"Return Code: 1 - One or more regions are NOT a valid AWS region"$'\n'"Checked: 2024-09-02"$'\n'""
file="bin/build/tools/aws.sh"
foundNames=()
rawComment="Summary: Check an AWS region code for validity"$'\n'"Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'"Argument: region ... - String. Required. The AWS Region to validate."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All regions are valid AWS region"$'\n'"Return Code: 1 - One or more regions are NOT a valid AWS region"$'\n'"Checked: 2024-09-02"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Summary: Check an AWS region code for validity"
usage="awsRegionValid"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsRegionValid'$'\e''[0m'$'\n'''$'\n''Summary: Check an AWS region code for validity'$'\n''Checks an AWS region identifier for validity as of September 2024.'$'\n''Note that passing no parameters returns success.'$'\n''Argument: region ... - String. Required. The AWS Region to validate.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - All regions are valid AWS region'$'\n''Return Code: 1 - One or more regions are NOT a valid AWS region'$'\n''Checked: 2024-09-02'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsRegionValid'$'\n'''$'\n''Summary: Check an AWS region code for validity'$'\n''Checks an AWS region identifier for validity as of September 2024.'$'\n''Note that passing no parameters returns success.'$'\n''Argument: region ... - String. Required. The AWS Region to validate.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - All regions are valid AWS region'$'\n''Return Code: 1 - One or more regions are NOT a valid AWS region'$'\n''Checked: 2024-09-02'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.445
