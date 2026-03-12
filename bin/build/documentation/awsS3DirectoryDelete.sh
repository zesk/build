#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--show - Flag. Optional. Show what would change, do not change anything."$'\n'"url ... - URL. Required. AWS S3 URL to delete"$'\n'""
base="aws.sh"
description="Delete a directory remotely on S3"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsS3DirectoryDelete"
foundNames=([0]="argument")
rawComment="Delete a directory remotely on S3"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --show - Flag. Optional. Show what would change, do not change anything."$'\n'"Argument: url ... - URL. Required. AWS S3 URL to delete"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Delete a directory remotely on S3"
summaryComputed="true"
usage="awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ..."
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
