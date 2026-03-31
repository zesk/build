#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-30
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="This tests \`AWS_ACCESS_KEY_ID\` and \`AWS_SECRET_ACCESS_KEY\` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1."$'\n'"Fails if either \`AWS_ACCESS_KEY_ID\` or \`AWS_SECRET_ACCESS_KEY\` is blank"$'\n'""
environment="AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)"$'\n'"AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)"$'\n'""
example="    if awsHasEnvironment; then"$'\n'"    ..."$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsHasEnvironment"
foundNames=([0]="argument" [1]="return_code" [2]="environment" [3]="example" [4]="summary")
rawComment="This tests \`AWS_ACCESS_KEY_ID\` and \`AWS_SECRET_ACCESS_KEY\` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1."$'\n'"Fails if either \`AWS_ACCESS_KEY_ID\` or \`AWS_SECRET_ACCESS_KEY\` is blank"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - If environment needs to be updated"$'\n'"Return Code: 1 - If the environment seems to be set already"$'\n'"Environment: AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)"$'\n'"Environment: AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)"$'\n'"Example:     if awsHasEnvironment; then"$'\n'"Example:     ..."$'\n'"Example:     fi"$'\n'"Summary: Test whether the AWS environment variables are set or not"$'\n'""$'\n'""
return_code="0 - If environment needs to be updated"$'\n'"1 - If the environment seems to be set already"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="0bb8ad1e144f99436ce0ae63227b8eccf2ae71a0"
summary="Test whether the AWS environment variables are set or not"$'\n'""
usage="awsHasEnvironment [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsHasEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''This tests '$'\e''[[(code)]mAWS_ACCESS_KEY_ID'$'\e''[[(reset)]m and '$'\e''[[(code)]mAWS_SECRET_ACCESS_KEY'$'\e''[[(reset)]m and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.'$'\n''Fails if either '$'\e''[[(code)]mAWS_ACCESS_KEY_ID'$'\e''[[(reset)]m or '$'\e''[[(code)]mAWS_SECRET_ACCESS_KEY'$'\e''[[(reset)]m is blank'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If environment needs to be updated'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If the environment seems to be set already'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mAWS_ACCESS_KEY_ID'$'\e''[[(reset)]m - Read-only. If blank, this function succeeds (environment needs to be updated)'$'\n''- '$'\e''[[(code)]mAWS_SECRET_ACCESS_KEY'$'\e''[[(reset)]m - Read-only. If blank, this function succeeds (environment needs to be updated)'$'\n'''$'\n''Example:'$'\n''    if awsHasEnvironment; then'$'\n''    ...'$'\n''    fi'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsHasEnvironment [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''This tests AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.'$'\n''Fails if either AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is blank'$'\n'''$'\n''Return codes:'$'\n''- 0 - If environment needs to be updated'$'\n''- 1 - If the environment seems to be set already'$'\n'''$'\n''Environment variables:'$'\n''- AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)'$'\n''- AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)'$'\n'''$'\n''Example:'$'\n''    if awsHasEnvironment; then'$'\n''    ...'$'\n''    fi'$'\n'''
