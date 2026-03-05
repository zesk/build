#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-05
# shellcheck disable=SC2034
argument="--profile profileName - String. Optional. The credentials profile to write (default value is \`default\`)"$'\n'"--force - Flag. Optional. Write the credentials file even if the profile already exists"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="Write the credentials to the AWS credentials file."$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsFromEnvironment"
foundNames=([0]="summary" [1]="argument")
rawComment="Write the credentials to the AWS credentials file."$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'"Summary: Write an AWS profile to the AWS credentials file"$'\n'"Argument: --profile profileName - String. Optional. The credentials profile to write (default value is \`default\`)"$'\n'"Argument: --force - Flag. Optional. Write the credentials file even if the profile already exists"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Write an AWS profile to the AWS credentials file"$'\n'""
usage="awsCredentialsFromEnvironment [ --profile profileName ] [ --force ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsCredentialsFromEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ --profile profileName ]'$'\e''[0m '$'\e''[[(blue)]m[ --force ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--profile profileName  '$'\e''[[(value)]mString. Optional. The credentials profile to write (default value is '$'\e''[[(code)]mdefault'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--force                '$'\e''[[(value)]mFlag. Optional. Write the credentials file even if the profile already exists'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                 '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Write the credentials to the AWS credentials file.'$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsFromEnvironment [ --profile profileName ] [ --force ] [ --help ]'$'\n'''$'\n''    --profile profileName  String. Optional. The credentials profile to write (default value is default)'$'\n''    --force                Flag. Optional. Write the credentials file even if the profile already exists'$'\n''    --help                 Flag. Optional. Display this help.'$'\n'''$'\n''Write the credentials to the AWS credentials file.'$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
