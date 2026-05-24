#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'profileName - The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)\n--help - Flag. Optional. Display this help.\n'
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Extract a profile from a credentials file\n\nIf the AWS credentials file is not found, returns exit code 1 and outputs nothing.\nIf the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.\n\n'
descriptionLineCount="5"
example=$'    setFile=$(fileTemporaryName "$handler") || return $?\n    if awsEnvironment "$profile" > "$setFile"; then\n    eval $(cat "$setFile")\n    rm "$setFile"\n    else\n    decorate error "Need $profile profile in aws credentials file"`\n    exit 1\n    fi\n'
file="bin/build/tools/aws.sh"
fn="awsCredentialsHasProfile"
fnMarker="awscredentialshasprofile"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="195"
rawComment=$'Extract a profile from a credentials file\nIf the AWS credentials file is not found, returns exit code 1 and outputs nothing.\nIf the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.\nSummary: Get credentials and output environment variables for AWS authentication\nArgument: profileName - The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)\nArgument: --help - Flag. Optional. Display this help.\nExample:     setFile=$(fileTemporaryName "$handler") || return $?\nExample:     if awsEnvironment "$profile" > "$setFile"; then\nExample:     eval $(cat "$setFile")\nExample:     rm "$setFile"\nExample:     else\nExample:     decorate error "Need $profile profile in aws credentials file"`\nExample:     exit 1\nExample:     fi\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
setFile=""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="195"
summary="Get credentials and output environment variables for AWS authentication"
summaryComputed=""
usage="awsCredentialsHasProfile [ profileName ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsCredentialsHasProfile'$'\e''[0m '$'\e''[[(blue)]m[ profileName ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mprofileName  '$'\e''[[(value)]mThe credentials profile to load (default value is '$'\e''[[(code)]mdefault'$'\e''[[(reset)]m and loads section identified by '$'\e''[[(code)]m[default]'$'\e''[[(reset)]m in '$'\e''[[(code)]m~/.aws/credentials'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extract a profile from a credentials file'$'\n'''$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    setFile=$(fileTemporaryName "$handler") || return $?'$'\n''    if awsEnvironment "$profile" > "$setFile"; then'$'\n''    eval $(cat "$setFile")'$'\n''    rm "$setFile"'$'\n''    else'$'\n''    decorate error "Need $profile profile in aws credentials file"'$'\e''[[(code)]m'$'\e''[[(reset)]m'$'\n''    exit 1'$'\n''    fi'
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsHasProfile [ profileName ] [ --help ]'$'\n'''$'\n''    profileName  The credentials profile to load (default value is default and loads section identified by [default] in ~/.aws/credentials)'$'\n''    --help       Flag. Optional. Display this help.'$'\n'''$'\n''Extract a profile from a credentials file'$'\n'''$'\n''If the AWS credentials file is not found, returns exit code 1 and outputs nothing.'$'\n''If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    setFile=$(fileTemporaryName "$handler") || return $?'$'\n''    if awsEnvironment "$profile" > "$setFile"; then'$'\n''    eval $(cat "$setFile")'$'\n''    rm "$setFile"'$'\n''    else'$'\n''    decorate error "Need $profile profile in aws credentials file"'$'\n''    exit 1'$'\n''    fi'
documentationPath="documentation/source/tools/aws.md"
