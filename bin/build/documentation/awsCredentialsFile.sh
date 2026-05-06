#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Verbose mode"$'\n'"--create - Flag. Optional. Create the directory and file if it does not exist"$'\n'"--home homeDirectory - Directory. Optional. Home directory to use instead of \`\$HOME\`."$'\n'""
base="aws.sh"
credentials=""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the credentials file path, optionally outputting errors"$'\n'""$'\n'"Pass a true-ish value to output warnings to stderr on failure"$'\n'""$'\n'"Pass any value to output warnings if the environment or file is not found; otherwise"$'\n'"output the credentials file path."$'\n'""$'\n'"If not found, returns with exit code 1."$'\n'""$'\n'""
descriptionLineCount="9"
example="    credentials=\$(awsCredentialsFile) || throwEnvironment \"\$handler\" \"No credentials file found\" || return \$?"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsFile"
fnMarker="awscredentialsfile"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="return_code")
line="59"
rawComment="Get the credentials file path, optionally outputting errors"$'\n'"Pass a true-ish value to output warnings to stderr on failure"$'\n'"Pass any value to output warnings if the environment or file is not found; otherwise"$'\n'"output the credentials file path."$'\n'"If not found, returns with exit code 1."$'\n'"Summary: Get the path to the AWS credentials file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --verbose - Flag. Optional. Verbose mode"$'\n'"Argument: --create - Flag. Optional. Create the directory and file if it does not exist"$'\n'"Argument: --home homeDirectory - Directory. Optional. Home directory to use instead of \`\$HOME\`."$'\n'"Example:     credentials=\$(awsCredentialsFile) || throwEnvironment \"\$handler\" \"No credentials file found\" || return \$?"$'\n'"Return Code: 1 - If \`\$HOME\` is not a directory or credentials file does not exist"$'\n'"Return Code: 0 - If credentials file is found and output to stdout"$'\n'""$'\n'""
return_code="1 - If \`\$HOME\` is not a directory or credentials file does not exist"$'\n'"0 - If credentials file is found and output to stdout"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="59"
summary="Get the path to the AWS credentials file"
summaryComputed=""
usage="awsCredentialsFile [ --help ] [ --verbose ] [ --create ] [ --home homeDirectory ]"
