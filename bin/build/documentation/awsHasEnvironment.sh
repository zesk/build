#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.\nFails if either `AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY` is blank\n\n'
descriptionLineCount="3"
environment=$'AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)\nAWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)\n'
example=$'    if awsHasEnvironment; then\n    ...\n    fi\n'
file="bin/build/tools/aws.sh"
fn="awsHasEnvironment"
fnMarker="awshasenvironment"
foundNames=([0]="argument" [1]="return_code" [2]="environment" [3]="example" [4]="summary")
line="117"
original="awsHasEnvironment"
rawComment=$'This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.\nFails if either `AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY` is blank\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - If environment needs to be updated\nReturn Code: 1 - If the environment seems to be set already\nEnvironment: AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)\nEnvironment: AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)\nExample:     if awsHasEnvironment; then\nExample:     ...\nExample:     fi\nSummary: Test whether the AWS environment variables are set or not\n\n'
return_code=$'0 - If environment needs to be updated\n1 - If the environment seems to be set already\n'
sourceFile="bin/build/tools/aws.sh"
sourceHash="9d4ed3ead974a5078fada208dc2c1f1e7d157af7"
sourceLine="117"
summary="Test whether the AWS environment variables are set or not"
summaryComputed=""
usage="awsHasEnvironment [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsHasEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''This tests '$'\e''[[(code)]mAWS_ACCESS_KEY_ID'$'\e''[[(reset)]m and '$'\e''[[(code)]mAWS_SECRET_ACCESS_KEY'$'\e''[[(reset)]m and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.'$'\n''Fails if either '$'\e''[[(code)]mAWS_ACCESS_KEY_ID'$'\e''[[(reset)]m or '$'\e''[[(code)]mAWS_SECRET_ACCESS_KEY'$'\e''[[(reset)]m is blank'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If environment needs to be updated'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If the environment seems to be set already'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mAWS_ACCESS_KEY_ID'$'\e''[[(reset)]m - Read-only. If blank, this function succeeds (environment needs to be updated)'$'\n''- '$'\e''[[(code)]mAWS_SECRET_ACCESS_KEY'$'\e''[[(reset)]m - Read-only. If blank, this function succeeds (environment needs to be updated)'$'\n'''$'\n''Example:'$'\n''    if awsHasEnvironment; then'$'\n''    ...'$'\n''    fi'
# shellcheck disable=SC2016
helpPlain='Usage: awsHasEnvironment [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''This tests AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.'$'\n''Fails if either AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is blank'$'\n'''$'\n''Return codes:'$'\n''- 0 - If environment needs to be updated'$'\n''- 1 - If the environment seems to be set already'$'\n'''$'\n''Environment variables:'$'\n''- AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)'$'\n''- AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)'$'\n'''$'\n''Example:'$'\n''    if awsHasEnvironment; then'$'\n''    ...'$'\n''    fi'
documentationPath="documentation/source/tools/aws.md"
