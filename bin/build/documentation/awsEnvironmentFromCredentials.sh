#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="profileName - String. Optional. The credentials profile to load (default value is \`default\` and loads section identified by \`[default]\` in \`~/.aws/credentials\`)"$'\n'"--profile profileName - String. Optional. The credentials profile to load (default value is \`default\` and loads section identified by \`[default]\` in \`~/.aws/credentials\`)"$'\n'"--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate \`AWS_ACCESS_KEY_ID\` and \`AWS_SECRET_ACCESS_KEY\` values."$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'"Both forms can be used, but the profile should be supplied once and only once."$'\n'""
example="    setFile=\$(fileTemporaryName \"\$handler\") || return \$?"$'\n'"    if awsEnvironment \"\$profile\" > \"\$setFile\"; then"$'\n'"    eval \$(cat \"\$setFile\")"$'\n'"    rm \"\$setFile\""$'\n'"    else"$'\n'"    decorate error \"Need \$profile profile in aws credentials file\"\`"$'\n'"    exit 1"$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsEnvironmentFromCredentials"
foundNames=([0]="summary" [1]="argument" [2]="example")
rawComment="Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate \`AWS_ACCESS_KEY_ID\` and \`AWS_SECRET_ACCESS_KEY\` values."$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'"Summary: Get credentials and output environment variables for AWS authentication"$'\n'"Argument: profileName - String. Optional. The credentials profile to load (default value is \`default\` and loads section identified by \`[default]\` in \`~/.aws/credentials\`)"$'\n'"Argument: --profile profileName - String. Optional. The credentials profile to load (default value is \`default\` and loads section identified by \`[default]\` in \`~/.aws/credentials\`)"$'\n'"Argument: --comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record)."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Both forms can be used, but the profile should be supplied once and only once."$'\n'"Example:     setFile=\$(fileTemporaryName \"\$handler\") || return \$?"$'\n'"Example:     if awsEnvironment \"\$profile\" > \"\$setFile\"; then"$'\n'"Example:     eval \$(cat \"\$setFile\")"$'\n'"Example:     rm \"\$setFile\""$'\n'"Example:     else"$'\n'"Example:     decorate error \"Need \$profile profile in aws credentials file\"\`"$'\n'"Example:     exit 1"$'\n'"Example:     fi"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
setFile=""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Get credentials and output environment variables for AWS authentication"$'\n'""
usage="awsEnvironmentFromCredentials [ profileName ] [ --profile profileName ] [ --comments ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
