#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--show - Flag. Optional. Show what would change, do not change anything."$'\n'"url ... - URL. Required. AWS S3 URL to delete"$'\n'""
base="aws.sh"
description="Delete a directory remotely on S3"$'\n'""
file="bin/build/tools/aws.sh"
foundNames=([0]="argument")
rawComment="Delete a directory remotely on S3"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --show - Flag. Optional. Show what would change, do not change anything."$'\n'"Argument: url ... - URL. Required. AWS S3 URL to delete"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1769185802"
summary="Delete a directory remotely on S3"
usage="awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsS3DirectoryDelete'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --show ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--show             '$'\e''[[(value)]mFlag. Optional. Show what would change, do not change anything.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl ...            '$'\e''[[(value)]mURL. Required. AWS S3 URL to delete'$'\e''[[(reset)]m'$'\n'''$'\n''Delete a directory remotely on S3'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ...'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --show             Flag. Optional. Show what would change, do not change anything.'$'\n''    url ...            URL. Required. AWS S3 URL to delete'$'\n'''$'\n''Delete a directory remotely on S3'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.549
