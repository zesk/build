#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="profileName - String. Optional. The credentials profile to load (default value is \`default\` and loads section identified by \`[default]\` in \`~/.aws/credentials\`)"$'\n'"--profile profileName - String. Optional. The credentials profile to load (default value is \`default\` and loads section identified by \`[default]\` in \`~/.aws/credentials\`)"$'\n'"--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate \`AWS_ACCESS_KEY_ID\` and \`AWS_SECRET_ACCESS_KEY\` values."$'\n'""$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'""$'\n'"Both forms can be used, but the profile should be supplied once and only once."$'\n'""
example="    setFile=\$(fileTemporaryName \"\$handler\") || return \$?"$'\n'"    if awsEnvironment \"\$profile\" > \"\$setFile\"; then"$'\n'"    eval \$(cat \"\$setFile\")"$'\n'"    rm \"\$setFile\""$'\n'"    else"$'\n'"    decorate error \"Need \$profile profile in aws credentials file\"\`"$'\n'"    exit 1"$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsEnvironmentFromCredentials"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Get credentials and output environment variables for AWS authentication"$'\n'""
usage="awsEnvironmentFromCredentials [ profileName ] [ --profile profileName ] [ --comments ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsEnvironmentFromCredentials[0m [94m[ profileName ][0m [94m[ --profile profileName ][0m [94m[ --comments ][0m [94m[ --help ][0m

    [94mprofileName            [1;97mString. Optional. The credentials profile to load (default value is [38;2;0;255;0;48;2;0;0;0mdefault[0m and loads section identified by [38;2;0;255;0;48;2;0;0;0m[default][0m in [38;2;0;255;0;48;2;0;0;0m~/.aws/credentials[0m)[0m
    [94m--profile profileName  [1;97mString. Optional. The credentials profile to load (default value is [38;2;0;255;0;48;2;0;0;0mdefault[0m and loads section identified by [38;2;0;255;0;48;2;0;0;0m[default][0m in [38;2;0;255;0;48;2;0;0;0m~/.aws/credentials[0m)[0m
    [94m--comments             [1;97mFlag. Optional. Write comments to the credentials file (in addition to updating the record).[0m
    [94m--help                 [1;97mFlag. Optional. Display this help.[0m

Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate [38;2;0;255;0;48;2;0;0;0mAWS_ACCESS_KEY_ID[0m and [38;2;0;255;0;48;2;0;0;0mAWS_SECRET_ACCESS_KEY[0m values.

If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.

Both forms can be used, but the profile should be supplied once and only once.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    setFile=$(fileTemporaryName "$handler") || return $?
    if awsEnvironment "$profile" > "$setFile"; then
    eval $(cat "$setFile")
    rm "$setFile"
    else
    decorate error "Need $profile profile in aws credentials file"[38;2;0;255;0;48;2;0;0;0m[0m
    exit 1
    fi
'
# shellcheck disable=SC2016
helpPlain='Usage: awsEnvironmentFromCredentials [ profileName ] [ --profile profileName ] [ --comments ] [ --help ]

    profileName            String. Optional. The credentials profile to load (default value is default and loads section identified by [default] in ~/.aws/credentials)
    --profile profileName  String. Optional. The credentials profile to load (default value is default and loads section identified by [default] in ~/.aws/credentials)
    --comments             Flag. Optional. Write comments to the credentials file (in addition to updating the record).
    --help                 Flag. Optional. Display this help.

Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY values.

If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.

Both forms can be used, but the profile should be supplied once and only once.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    setFile=$(fileTemporaryName "$handler") || return $?
    if awsEnvironment "$profile" > "$setFile"; then
    eval $(cat "$setFile")
    rm "$setFile"
    else
    decorate error "Need $profile profile in aws credentials file"
    exit 1
    fi
'
