#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--verbose - Flag. Optional. Verbose mode\n--create - Flag. Optional. Create the directory and file if it does not exist\n--home homeDirectory - Directory. Optional. Home directory to use instead of `$HOME`.\n'
base="aws.sh"
credentials=""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the credentials file path, optionally outputting errors\n\nPass a true-ish value to output warnings to stderr on failure\n\nPass any value to output warnings if the environment or file is not found; otherwise\noutput the credentials file path.\n\nIf not found, returns with exit code 1.\n\n'
descriptionLineCount="9"
example=$'    credentials=$(awsCredentialsFile) || throwEnvironment "$handler" "No credentials file found" || return $?\n'
file="bin/build/tools/aws.sh"
fn="awsCredentialsFile"
fnMarker="awscredentialsfile"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="return_code")
line="59"
rawComment=$'Get the credentials file path, optionally outputting errors\nPass a true-ish value to output warnings to stderr on failure\nPass any value to output warnings if the environment or file is not found; otherwise\noutput the credentials file path.\nIf not found, returns with exit code 1.\nSummary: Get the path to the AWS credentials file\nArgument: --help - Flag. Optional. Display this help.\nArgument: --verbose - Flag. Optional. Verbose mode\nArgument: --create - Flag. Optional. Create the directory and file if it does not exist\nArgument: --home homeDirectory - Directory. Optional. Home directory to use instead of `$HOME`.\nExample:     credentials=$(awsCredentialsFile) || throwEnvironment "$handler" "No credentials file found" || return $?\nReturn Code: 1 - If `$HOME` is not a directory or credentials file does not exist\nReturn Code: 0 - If credentials file is found and output to stdout\n\n'
return_code=$'1 - If `$HOME` is not a directory or credentials file does not exist\n0 - If credentials file is found and output to stdout\n'
sourceFile="bin/build/tools/aws.sh"
sourceHash="9d4ed3ead974a5078fada208dc2c1f1e7d157af7"
sourceLine="59"
summary="Get the path to the AWS credentials file"
summaryComputed=""
usage="awsCredentialsFile [ --help ] [ --verbose ] [ --create ] [ --home homeDirectory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsCredentialsFile'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --create ]'$'\e''[0m '$'\e''[[(blue)]m[ --home homeDirectory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose             '$'\e''[[(value)]mFlag. Optional. Verbose mode'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--create              '$'\e''[[(value)]mFlag. Optional. Create the directory and file if it does not exist'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--home homeDirectory  '$'\e''[[(value)]mDirectory. Optional. Home directory to use instead of '$'\e''[[(code)]m$HOME'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the credentials file path, optionally outputting errors'$'\n'''$'\n''Pass a true-ish value to output warnings to stderr on failure'$'\n'''$'\n''Pass any value to output warnings if the environment or file is not found; otherwise'$'\n''output the credentials file path.'$'\n'''$'\n''If not found, returns with exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If '$'\e''[[(code)]m$HOME'$'\e''[[(reset)]m is not a directory or credentials file does not exist'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If credentials file is found and output to stdout'$'\n'''$'\n''Example:'$'\n''    credentials=$(awsCredentialsFile) || throwEnvironment "$handler" "No credentials file found" || return $?'
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsFile [ --help ] [ --verbose ] [ --create ] [ --home homeDirectory ]'$'\n'''$'\n''    --help                Flag. Optional. Display this help.'$'\n''    --verbose             Flag. Optional. Verbose mode'$'\n''    --create              Flag. Optional. Create the directory and file if it does not exist'$'\n''    --home homeDirectory  Directory. Optional. Home directory to use instead of $HOME.'$'\n'''$'\n''Get the credentials file path, optionally outputting errors'$'\n'''$'\n''Pass a true-ish value to output warnings to stderr on failure'$'\n'''$'\n''Pass any value to output warnings if the environment or file is not found; otherwise'$'\n''output the credentials file path.'$'\n'''$'\n''If not found, returns with exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If $HOME is not a directory or credentials file does not exist'$'\n''- 0 - If credentials file is found and output to stdout'$'\n'''$'\n''Example:'$'\n''    credentials=$(awsCredentialsFile) || throwEnvironment "$handler" "No credentials file found" || return $?'
documentationPath="documentation/source/tools/aws.md"
