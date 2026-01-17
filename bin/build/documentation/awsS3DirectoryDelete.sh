#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"--handler handler -  Function. Optional.Use this error handler instead of the default error handler."$'\n'"--show -  Flag. Optional.Show what would change, do not change anything."$'\n'"url ... -  URL. Required. AWS S3 URL to delete"$'\n'""
base="aws.sh"
description="Delete a directory remotely on S3"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsS3DirectoryDelete"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768683999"
summary="Delete a directory remotely on S3"
usage="awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ..."
