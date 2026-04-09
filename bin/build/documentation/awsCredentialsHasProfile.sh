#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="profileName - The credentials profile to load (default value is \`default\` and loads section identified by \`[default]\` in \`~/.aws/credentials\`)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="Extract a profile from a credentials file"$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'""
example="    setFile=\$(fileTemporaryName \"\$handler\") || return \$?"$'\n'"    if awsEnvironment \"\$profile\" > \"\$setFile\"; then"$'\n'"    eval \$(cat \"\$setFile\")"$'\n'"    rm \"\$setFile\""$'\n'"    else"$'\n'"    decorate error \"Need \$profile profile in aws credentials file\"\`"$'\n'"    exit 1"$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsHasProfile"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="195"
lowerFn="awscredentialshasprofile"
rawComment="Extract a profile from a credentials file"$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'"Summary: Get credentials and output environment variables for AWS authentication"$'\n'"Argument: profileName - The credentials profile to load (default value is \`default\` and loads section identified by \`[default]\` in \`~/.aws/credentials\`)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     setFile=\$(fileTemporaryName \"\$handler\") || return \$?"$'\n'"Example:     if awsEnvironment \"\$profile\" > \"\$setFile\"; then"$'\n'"Example:     eval \$(cat \"\$setFile\")"$'\n'"Example:     rm \"\$setFile\""$'\n'"Example:     else"$'\n'"Example:     decorate error \"Need \$profile profile in aws credentials file\"\`"$'\n'"Example:     exit 1"$'\n'"Example:     fi"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
setFile=""
sourceFile="bin/build/tools/aws.sh"
sourceHash="16fc69e4b0e8bc369cc44854fd5c323db626923a"
sourceLine="195"
summary="Get credentials and output environment variables for AWS authentication"$'\n'""
usage="awsCredentialsHasProfile [ profileName ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsCredentialsHasProfile'$'\e''[0m '$'\e''[[(blue)]m[ profileName ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mprofileName  '$'\e''[[(value)]mThe credentials profile to load (default value is '$'\e''[[(code)]mdefault'$'\e''[[(reset)]m and loads section identified by '$'\e''[[(code)]m[default]'$'\e''[[(reset)]m in '$'\e''[[(code)]m~/.aws/credentials'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extract a profile from a credentials file'$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    setFile=$(fileTemporaryName "$handler") || return $?'$'\n''    if awsEnvironment "$profile" > "$setFile"; then'$'\n''    eval $(cat "$setFile")'$'\n''    rm "$setFile"'$'\n''    else'$'\n''    decorate error "Need $profile profile in aws credentials file"'$'\e''[[(code)]m'$'\e''[[(reset)]m'$'\n''    exit 1'$'\n''    fi'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsHasProfile [ profileName ] [ --help ]'$'\n'''$'\n''    profileName  The credentials profile to load (default value is default and loads section identified by [default] in ~/.aws/credentials)'$'\n''    --help       Flag. Optional. Display this help.'$'\n'''$'\n''Extract a profile from a credentials file'$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    setFile=$(fileTemporaryName "$handler") || return $?'$'\n''    if awsEnvironment "$profile" > "$setFile"; then'$'\n''    eval $(cat "$setFile")'$'\n''    rm "$setFile"'$'\n''    else'$'\n''    decorate error "Need $profile profile in aws credentials file"'$'\n''    exit 1'$'\n''    fi'$'\n'''
documentationPath="documentation/source/tools/aws.md"
