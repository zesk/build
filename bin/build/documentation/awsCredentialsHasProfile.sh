#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="profileName - The credentials profile to load (default value is \`default\` and loads section identified by \`[default]\` in \`~/.aws/credentials\`)"$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="aws.sh"
description="Extract a profile from a credentials file"$'\n'""$'\n'"If the AWS credentials file is not found, returns exit code 1 and outputs nothing."$'\n'"If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing."$'\n'""$'\n'""
example="    setFile=\$(fileTemporaryName \"\$handler\") || return \$?"$'\n'"    if awsEnvironment \"\$profile\" > \"\$setFile\"; then"$'\n'"    eval \$(cat \"\$setFile\")"$'\n'"    rm \"\$setFile\""$'\n'"    else"$'\n'"    decorate error \"Need \$profile profile in aws credentials file\"\`"$'\n'"    exit 1"$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsHasProfile"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768683999"
summary="Get credentials and output environment variables for AWS authentication"$'\n'""
usage="awsCredentialsHasProfile [ profileName ] [ --help ]"
