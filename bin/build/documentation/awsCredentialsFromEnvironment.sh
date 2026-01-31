#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="aws.sh"
description="Write the credentials to the AWS credentials file."$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'"Summary: Write an AWS profile to the AWS credentials file"$'\n'"Argument: --profile profileName - String. Optional. The credentials profile to write (default value is \`default\`)"$'\n'"Argument: --force - Flag. Optional. Write the credentials file even if the profile already exists"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/aws.sh"
foundNames=()
rawComment="Write the credentials to the AWS credentials file."$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'"Summary: Write an AWS profile to the AWS credentials file"$'\n'"Argument: --profile profileName - String. Optional. The credentials profile to write (default value is \`default\`)"$'\n'"Argument: --force - Flag. Optional. Write the credentials file even if the profile already exists"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Write the credentials to the AWS credentials file."
usage="awsCredentialsFromEnvironment"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsCredentialsFromEnvironment'$'\e''[0m'$'\n'''$'\n''Write the credentials to the AWS credentials file.'$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n''Summary: Write an AWS profile to the AWS credentials file'$'\n''Argument: --profile profileName - String. Optional. The credentials profile to write (default value is '$'\e''[[(code)]mdefault'$'\e''[[(reset)]m)'$'\n''Argument: --force - Flag. Optional. Write the credentials file even if the profile already exists'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsFromEnvironment'$'\n'''$'\n''Write the credentials to the AWS credentials file.'$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n''Summary: Write an AWS profile to the AWS credentials file'$'\n''Argument: --profile profileName - String. Optional. The credentials profile to write (default value is default)'$'\n''Argument: --force - Flag. Optional. Write the credentials file even if the profile already exists'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.5
