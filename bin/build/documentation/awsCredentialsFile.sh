#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Verbose mode"$'\n'"--create - Flag. Optional. Create the directory and file if it does not exist"$'\n'"--home homeDirectory - Directory. Optional. Home directory to use instead of \`\$HOME\`."$'\n'""
base="aws.sh"
credentials=""
description="Get the credentials file path, optionally outputting errors"$'\n'"Pass a true-ish value to output warnings to stderr on failure"$'\n'"Pass any value to output warnings if the environment or file is not found; otherwise"$'\n'"output the credentials file path."$'\n'"If not found, returns with exit code 1."$'\n'""
example="    credentials=\$(awsCredentialsFile) || throwEnvironment \"\$handler\" \"No credentials file found\" || return \$?"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsFile"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="return_code")
rawComment="Get the credentials file path, optionally outputting errors"$'\n'"Pass a true-ish value to output warnings to stderr on failure"$'\n'"Pass any value to output warnings if the environment or file is not found; otherwise"$'\n'"output the credentials file path."$'\n'"If not found, returns with exit code 1."$'\n'"Summary: Get the path to the AWS credentials file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --verbose - Flag. Optional. Verbose mode"$'\n'"Argument: --create - Flag. Optional. Create the directory and file if it does not exist"$'\n'"Argument: --home homeDirectory - Directory. Optional. Home directory to use instead of \`\$HOME\`."$'\n'"Example:     credentials=\$(awsCredentialsFile) || throwEnvironment \"\$handler\" \"No credentials file found\" || return \$?"$'\n'"Return Code: 1 - If \`\$HOME\` is not a directory or credentials file does not exist"$'\n'"Return Code: 0 - If credentials file is found and output to stdout"$'\n'""$'\n'""
return_code="1 - If \`\$HOME\` is not a directory or credentials file does not exist"$'\n'"0 - If credentials file is found and output to stdout"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Get the path to the AWS credentials file"$'\n'""
usage="awsCredentialsFile [ --help ] [ --verbose ] [ --create ] [ --home homeDirectory ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
