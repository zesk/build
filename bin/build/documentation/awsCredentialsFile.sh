#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Verbose mode"$'\n'"--create - Flag. Optional. Create the directory and file if it does not exist"$'\n'"--home homeDirectory - Directory. Optional. Home directory to use instead of \`\$HOME\`."$'\n'""
base="aws.sh"
credentials=""
description="Get the credentials file path, optionally outputting errors"$'\n'""$'\n'"Pass a true-ish value to output warnings to stderr on failure"$'\n'""$'\n'"Pass any value to output warnings if the environment or file is not found; otherwise"$'\n'"output the credentials file path."$'\n'""$'\n'"If not found, returns with exit code 1."$'\n'""$'\n'"Return Code: 1 - If \`\$HOME\` is not a directory or credentials file does not exist"$'\n'"Return Code: 0 - If credentials file is found and output to stdout"$'\n'""$'\n'"shellcheck disable=SC2120"$'\n'""
example="    credentials=\$(awsCredentialsFile) || throwEnvironment \"\$handler\" \"No credentials file found\" || return \$?"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsCredentialsFile"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1769063211"
summary="Get the path to the AWS credentials file"$'\n'""
usage="awsCredentialsFile [ --help ] [ --verbose ] [ --create ] [ --home homeDirectory ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsCredentialsFile[0m [94m[ --help ][0m [94m[ --verbose ][0m [94m[ --create ][0m [94m[ --home homeDirectory ][0m

    [94m--help                [1;97mFlag. Optional. Display this help.[0m
    [94m--verbose             [1;97mFlag. Optional. Verbose mode[0m
    [94m--create              [1;97mFlag. Optional. Create the directory and file if it does not exist[0m
    [94m--home homeDirectory  [1;97mDirectory. Optional. Home directory to use instead of [38;2;0;255;0;48;2;0;0;0m$HOME[0m.[0m

Get the credentials file path, optionally outputting errors

Pass a true-ish value to output warnings to stderr on failure

Pass any value to output warnings if the environment or file is not found; otherwise
output the credentials file path.

If not found, returns with exit code 1.

Return Code: 1 - If [38;2;0;255;0;48;2;0;0;0m$HOME[0m is not a directory or credentials file does not exist
Return Code: 0 - If credentials file is found and output to stdout

shellcheck disable=SC2120

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    credentials=$(awsCredentialsFile) || throwEnvironment "$handler" "No credentials file found" || return $?
'
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsFile [ --help ] [ --verbose ] [ --create ] [ --home homeDirectory ]

    --help                Flag. Optional. Display this help.
    --verbose             Flag. Optional. Verbose mode
    --create              Flag. Optional. Create the directory and file if it does not exist
    --home homeDirectory  Directory. Optional. Home directory to use instead of $HOME.

Get the credentials file path, optionally outputting errors

Pass a true-ish value to output warnings to stderr on failure

Pass any value to output warnings if the environment or file is not found; otherwise
output the credentials file path.

If not found, returns with exit code 1.

Return Code: 1 - If $HOME is not a directory or credentials file does not exist
Return Code: 0 - If credentials file is found and output to stdout

shellcheck disable=SC2120

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    credentials=$(awsCredentialsFile) || throwEnvironment "$handler" "No credentials file found" || return $?
'
