#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--profile profileName - String. Optional. The credentials profile to remove."$'\n'"--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"profileName - String. Optional. The credentials profile to remove."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="Remove credentials from the AWS credentials file"$'\n'""$'\n'"If the AWS credentials file is not found, succeeds."$'\n'""$'\n'"You can supply the profile using the \`--profile\` or directly, but just one."$'\n'""$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsRemove"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1769063211"
summary="Remove credentials from the AWS credentials file"
usage="awsCredentialsRemove [ --profile profileName ] [ --comments ] [ profileName ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsCredentialsRemove[0m [94m[ --profile profileName ][0m [94m[ --comments ][0m [94m[ profileName ][0m [94m[ --help ][0m

    [94m--profile profileName  [1;97mString. Optional. The credentials profile to remove.[0m
    [94m--comments             [1;97mFlag. Optional. Write comments to the credentials file (in addition to updating the record).[0m
    [94mprofileName            [1;97mString. Optional. The credentials profile to remove.[0m
    [94m--help                 [1;97mFlag. Optional. Display this help.[0m

Remove credentials from the AWS credentials file

If the AWS credentials file is not found, succeeds.

You can supply the profile using the [38;2;0;255;0;48;2;0;0;0m--profile[0m or directly, but just one.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsRemove [ --profile profileName ] [ --comments ] [ profileName ] [ --help ]

    --profile profileName  String. Optional. The credentials profile to remove.
    --comments             Flag. Optional. Write comments to the credentials file (in addition to updating the record).
    profileName            String. Optional. The credentials profile to remove.
    --help                 Flag. Optional. Display this help.

Remove credentials from the AWS credentials file

If the AWS credentials file is not found, succeeds.

You can supply the profile using the --profile or directly, but just one.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
