#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n--show - Flag. Optional. Show what would change, do not change anything.\nurl ... - URL. Required. AWS S3 URL to delete\n'
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Delete a directory remotely on S3\n\n'
descriptionLineCount="2"
file="bin/build/tools/aws.sh"
fn="awsS3DirectoryDelete"
fnMarker="awss3directorydelete"
foundNames=([0]="argument")
line="417"
rawComment=$'Delete a directory remotely on S3\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: --show - Flag. Optional. Show what would change, do not change anything.\nArgument: url ... - URL. Required. AWS S3 URL to delete\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/aws.sh"
sourceHash="9d4ed3ead974a5078fada208dc2c1f1e7d157af7"
sourceLine="417"
summary="Delete a directory remotely on S3"
summaryComputed="true"
usage="awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsS3DirectoryDelete'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --show ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--show             '$'\e''[[(value)]mFlag. Optional. Show what would change, do not change anything.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl ...            '$'\e''[[(value)]mURL. Required. AWS S3 URL to delete'$'\e''[[(reset)]m'$'\n'''$'\n''Delete a directory remotely on S3'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ...'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --show             Flag. Optional. Show what would change, do not change anything.'$'\n''    url ...            URL. Required. AWS S3 URL to delete'$'\n'''$'\n''Delete a directory remotely on S3'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/aws.md"
