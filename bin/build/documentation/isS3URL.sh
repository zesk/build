#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="value - EmptyString. Value to check."$'\n'""
base="aws.sh"
description="Is the URL passed in a S3 URL?"$'\n'"Without arguments, displays help."$'\n'""
exitCode="0"
file="bin/build/tools/aws.sh"
rawComment="Is the URL passed in a S3 URL?"$'\n'"Argument: value - EmptyString. Value to check."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1769185802"
summary="Is the URL passed in a S3 URL?"
usage="isS3URL [ value ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]misS3URL'$'\e''[0m '$'\e''[[blue]m[ value ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mvalue  '$'\e''[[value]mEmptyString. Value to check.'$'\e''[[reset]m'$'\n'''$'\n''Is the URL passed in a S3 URL?'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isS3URL [ value ]'$'\n'''$'\n''    value  EmptyString. Value to check.'$'\n'''$'\n''Is the URL passed in a S3 URL?'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
