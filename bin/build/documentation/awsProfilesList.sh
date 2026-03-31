#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-30
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="List AWS profiles available in the credentials file"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsProfilesList"
foundNames=([0]="argument" [1]="see")
rawComment="List AWS profiles available in the credentials file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: awsCredentialsFile"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="awsCredentialsFile"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="0bb8ad1e144f99436ce0ae63227b8eccf2ae71a0"
summary="List AWS profiles available in the credentials file"
summaryComputed="true"
usage="awsProfilesList [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsProfilesList'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List AWS profiles available in the credentials file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsProfilesList [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List AWS profiles available in the credentials file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
