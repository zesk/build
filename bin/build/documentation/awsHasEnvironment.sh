#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'""
base="aws.sh"
description="This tests \`AWS_ACCESS_KEY_ID\` and \`AWS_SECRET_ACCESS_KEY\` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1."$'\n'"Fails if either \`AWS_ACCESS_KEY_ID\` or \`AWS_SECRET_ACCESS_KEY\` is blank"$'\n'""$'\n'"Return Code: 0 - If environment needs to be updated"$'\n'"Return Code: 1 - If the environment seems to be set already"$'\n'""$'\n'""
environment="AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)"$'\n'"AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)"$'\n'""
example="    if awsHasEnvironment; then"$'\n'"    ..."$'\n'"    fi"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsHasEnvironment"
foundNames=([0]="argument" [1]="environment" [2]="example" [3]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768683999"
summary="Test whether the AWS environment variables are set or not"$'\n'""
usage="awsHasEnvironment [ --help ]"
