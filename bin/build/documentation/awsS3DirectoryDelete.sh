#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--show - Flag. Optional. Show what would change, do not change anything."$'\n'"url ... - URL. Required. AWS S3 URL to delete"$'\n'""
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Delete a directory remotely on S3"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/aws.sh"
fn="awsS3DirectoryDelete"
fnMarker="awss3directorydelete"
foundNames=([0]="argument")
line="417"
rawComment="Delete a directory remotely on S3"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --show - Flag. Optional. Show what would change, do not change anything."$'\n'"Argument: url ... - URL. Required. AWS S3 URL to delete"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="417"
summary="Delete a directory remotely on S3"
summaryComputed="true"
usage="awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ..."
