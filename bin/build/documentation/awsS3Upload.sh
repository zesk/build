#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--target target - Required. S3 URL. S3 URL to upload to (with path)"$'\n'"item - Required. A file or directory to upload to S3. All files and directories are uploaded as the same name in the top-level directory target."$'\n'"--profile profileName - String. Optional. S3 Profile to use when using S3"$'\n'""
base="aws.sh"
description="Upload a set of files or directories to S3."$'\n'"Creates a \`manifest.json\` file at target with structure:"$'\n'"- hostname - host name which sent results"$'\n'"- created - Milliseconds creation time"$'\n'"- createdString - Milliseconds creation time in current locale language"$'\n'"- arguments - arguments to this function"$'\n'"Creates a \`files.json\` with a list of files as well at target"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsS3Upload"
foundNames=([0]="argument")
rawComment="Upload a set of files or directories to S3."$'\n'"Creates a \`manifest.json\` file at target with structure:"$'\n'"- hostname - host name which sent results"$'\n'"- created - Milliseconds creation time"$'\n'"- createdString - Milliseconds creation time in current locale language"$'\n'"- arguments - arguments to this function"$'\n'"Creates a \`files.json\` with a list of files as well at target"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --target target - Required. S3 URL. S3 URL to upload to (with path)"$'\n'"Argument: item - Required. A file or directory to upload to S3. All files and directories are uploaded as the same name in the top-level directory target."$'\n'"Argument: --profile profileName - String. Optional. S3 Profile to use when using S3"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Upload a set of files or directories to S3."
summaryComputed="true"
usage="awsS3Upload [ --help ] [ --handler handler ] --target target item [ --profile profileName ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
