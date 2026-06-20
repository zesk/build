#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--profile profileName - String. Optional. The credentials profile to write (default value is `default`)\n--force - Flag. Optional. Write the credentials file even if the profile already exists\n--help - Flag. Optional. Display this help.\n'
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Write the credentials to the AWS credentials file.\n\nIf the AWS credentials file is not found, returns exit code 1 and outputs nothing.\nIf the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.\n\n'
descriptionLineCount="5"
file="bin/build/tools/aws.sh"
fn="awsCredentialsFromEnvironment"
fnMarker="awscredentialsfromenvironment"
foundNames=([0]="summary" [1]="argument")
line="252"
original="awsCredentialsFromEnvironment"
rawComment=$'Write the credentials to the AWS credentials file.\nIf the AWS credentials file is not found, returns exit code 1 and outputs nothing.\nIf the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.\nSummary: Write an AWS profile to the AWS credentials file\nArgument: --profile profileName - String. Optional. The credentials profile to write (default value is `default`)\nArgument: --force - Flag. Optional. Write the credentials file even if the profile already exists\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/aws.sh"
sourceHash="9d4ed3ead974a5078fada208dc2c1f1e7d157af7"
sourceLine="252"
summary="Write an AWS profile to the AWS credentials file"
summaryComputed=""
usage="awsCredentialsFromEnvironment [ --profile profileName ] [ --force ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsCredentialsFromEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ --profile profileName ]'$'\e''[0m '$'\e''[[(blue)]m[ --force ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--profile profileName  '$'\e''[[(value)]mString. Optional. The credentials profile to write (default value is '$'\e''[[(code)]mdefault'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--force                '$'\e''[[(value)]mFlag. Optional. Write the credentials file even if the profile already exists'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                 '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Write the credentials to the AWS credentials file.'$'\n'''$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsFromEnvironment [ --profile profileName ] [ --force ] [ --help ]'$'\n'''$'\n''    --profile profileName  String. Optional. The credentials profile to write (default value is default)'$'\n''    --force                Flag. Optional. Write the credentials file even if the profile already exists'$'\n''    --help                 Flag. Optional. Display this help.'$'\n'''$'\n''Write the credentials to the AWS credentials file.'$'\n'''$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/aws.md"
