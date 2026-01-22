#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--show - Flag. Optional. Show what would change, do not change anything."$'\n'"url ... - URL. Required. AWS S3 URL to delete"$'\n'""
base="aws.sh"
description="Delete a directory remotely on S3"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsS3DirectoryDelete"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Delete a directory remotely on S3"
usage="awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsS3DirectoryDelete[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --show ][0m [38;2;255;255;0m[35;48;2;0;0;0murl ...[0m[0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--show             [1;97mFlag. Optional. Show what would change, do not change anything.[0m
    [31murl ...            [1;97mURL. Required. AWS S3 URL to delete[0m

Delete a directory remotely on S3

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ...

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    --show             Flag. Optional. Show what would change, do not change anything.
    url ...            URL. Required. AWS S3 URL to delete

Delete a directory remotely on S3

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
