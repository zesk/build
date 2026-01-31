#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="aws.sh"
description="Delete a directory remotely on S3"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --show - Flag. Optional. Show what would change, do not change anything."$'\n'"Argument: url ... - URL. Required. AWS S3 URL to delete"$'\n'""
file="bin/build/tools/aws.sh"
foundNames=()
rawComment="Delete a directory remotely on S3"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --show - Flag. Optional. Show what would change, do not change anything."$'\n'"Argument: url ... - URL. Required. AWS S3 URL to delete"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Delete a directory remotely on S3"
usage="awsS3DirectoryDelete"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsS3DirectoryDelete'$'\e''[0m'$'\n'''$'\n''Delete a directory remotely on S3'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: --show - Flag. Optional. Show what would change, do not change anything.'$'\n''Argument: url ... - URL. Required. AWS S3 URL to delete'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsS3DirectoryDelete'$'\n'''$'\n''Delete a directory remotely on S3'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: --show - Flag. Optional. Show what would change, do not change anything.'$'\n''Argument: url ... - URL. Required. AWS S3 URL to delete'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.471
