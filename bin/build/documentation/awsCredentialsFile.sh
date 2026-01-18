#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Verbose mode"$'\n'"--create - Flag. Optional. Create the directory and file if it does not exist"$'\n'"--home homeDirectory - Directory. Optional. Home directory to use instead of \`\$HOME\`."$'\n'""
base="aws.sh"
description="Get the credentials file path, optionally outputting errors"$'\n'""$'\n'"Pass a true-ish value to output warnings to stderr on failure"$'\n'""$'\n'"Pass any value to output warnings if the environment or file is not found; otherwise"$'\n'"output the credentials file path."$'\n'""$'\n'"If not found, returns with exit code 1."$'\n'""$'\n'"Return Code: 1 - If \`\$HOME\` is not a directory or credentials file does not exist"$'\n'"Return Code: 0 - If credentials file is found and output to stdout"$'\n'""$'\n'"shellcheck disable=SC2120"$'\n'""
example="    credentials=\$(awsCredentialsFile) || throwEnvironment \"\$handler\" \"No credentials file found\" || return \$?"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsFile"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768721469"
summary="Get the path to the AWS credentials file"$'\n'""
usage="awsCredentialsFile [ --help ] [ --verbose ] [ --create ] [ --home homeDirectory ]"
