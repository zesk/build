#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--target target - Required. S3 URL. S3 URL to upload to (with path)"$'\n'"item - Required. A file or directory to upload to S3. All files and directories are uploaded as the same name in the top-level directory target."$'\n'"--profile profileName - String. Optional. S3 Profile to use when using S3"$'\n'""
base="aws.sh"
description="Upload a set of files or directories to S3."$'\n'"Creates a \`manifest.json\` file at target with structure:"$'\n'"- hostname - host name which sent results"$'\n'"- created - Milliseconds creation time"$'\n'"- createdString - Milliseconds creation time in current locale language"$'\n'"- arguments - arguments to this function"$'\n'"Creates a \`files.json\` with a list of files as well at target"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsS3Upload"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Upload a set of files or directories to S3."
usage="awsS3Upload [ --help ] [ --handler handler ] --target target item [ --profile profileName ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsS3Upload[0m [94m[ --help ][0m [94m[ --handler handler ][0m [38;2;255;255;0m[35;48;2;0;0;0m--target target[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mitem[0m[0m [94m[ --profile profileName ][0m

    [94m--help                 [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler      [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [31m--target target        [1;97mRequired. S3 URL. S3 URL to upload to (with path)[0m
    [31mitem                   [1;97mRequired. A file or directory to upload to S3. All files and directories are uploaded as the same name in the top-level directory target.[0m
    [94m--profile profileName  [1;97mString. Optional. S3 Profile to use when using S3[0m

Upload a set of files or directories to S3.
Creates a [38;2;0;255;0;48;2;0;0;0mmanifest.json[0m file at target with structure:
- hostname - host name which sent results
- created - Milliseconds creation time
- createdString - Milliseconds creation time in current locale language
- arguments - arguments to this function
Creates a [38;2;0;255;0;48;2;0;0;0mfiles.json[0m with a list of files as well at target

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: awsS3Upload [ --help ] [ --handler handler ] --target target item [ --profile profileName ]

    --help                 Flag. Optional. Display this help.
    --handler handler      Function. Optional. Use this error handler instead of the default error handler.
    --target target        Required. S3 URL. S3 URL to upload to (with path)
    item                   Required. A file or directory to upload to S3. All files and directories are uploaded as the same name in the top-level directory target.
    --profile profileName  String. Optional. S3 Profile to use when using S3

Upload a set of files or directories to S3.
Creates a manifest.json file at target with structure:
- hostname - host name which sent results
- created - Milliseconds creation time
- createdString - Milliseconds creation time in current locale language
- arguments - arguments to this function
Creates a files.json with a list of files as well at target

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
