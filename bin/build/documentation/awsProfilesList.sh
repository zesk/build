#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List AWS profiles available in the credentials file\n\n'
descriptionLineCount="2"
file="bin/build/tools/aws.sh"
fn="awsProfilesList"
fnMarker="awsprofileslist"
foundNames=([0]="argument" [1]="see")
line="135"
original="awsProfilesList"
rawComment=$'List AWS profiles available in the credentials file\nArgument: --help - Flag. Optional. Display this help.\nSee: awsCredentialsFile\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'awsCredentialsFile\n'
sourceFile="bin/build/tools/aws.sh"
sourceHash="9d4ed3ead974a5078fada208dc2c1f1e7d157af7"
sourceLine="135"
summary="List AWS profiles available in the credentials file"
summaryComputed="true"
usage="awsProfilesList [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsProfilesList'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List AWS profiles available in the credentials file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: awsProfilesList [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List AWS profiles available in the credentials file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/aws.md"
