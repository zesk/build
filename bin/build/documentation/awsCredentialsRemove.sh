#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--profile profileName - String. Optional. The credentials profile to remove.\n--comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record).\nprofileName - String. Optional. The credentials profile to remove.\n--help - Flag. Optional. Display this help.\n'
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove credentials from the AWS credentials file\n\nIf the AWS credentials file is not found, succeeds.\n\nYou can supply the profile using the `--profile` or directly, but just one.\n\n'
descriptionLineCount="6"
file="bin/build/tools/aws.sh"
fn="awsCredentialsRemove"
fnMarker="awscredentialsremove"
foundNames=([0]="argument")
line="234"
rawComment=$'Remove credentials from the AWS credentials file\nIf the AWS credentials file is not found, succeeds.\nYou can supply the profile using the `--profile` or directly, but just one.\nArgument: --profile profileName - String. Optional. The credentials profile to remove.\nArgument: --comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record).\nArgument: profileName - String. Optional. The credentials profile to remove.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="234"
summary="Remove credentials from the AWS credentials file"
summaryComputed="true"
usage="awsCredentialsRemove [ --profile profileName ] [ --comments ] [ profileName ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsCredentialsRemove'$'\e''[0m '$'\e''[[(blue)]m[ --profile profileName ]'$'\e''[0m '$'\e''[[(blue)]m[ --comments ]'$'\e''[0m '$'\e''[[(blue)]m[ profileName ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--profile profileName  '$'\e''[[(value)]mString. Optional. The credentials profile to remove.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--comments             '$'\e''[[(value)]mFlag. Optional. Write comments to the credentials file (in addition to updating the record).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mprofileName            '$'\e''[[(value)]mString. Optional. The credentials profile to remove.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                 '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove credentials from the AWS credentials file'$'\n'''$'\n''If the AWS credentials file is not found, succeeds.'$'\n'''$'\n''You can supply the profile using the '$'\e''[[(code)]m--profile'$'\e''[[(reset)]m or directly, but just one.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: awsCredentialsRemove [ --profile profileName ] [ --comments ] [ profileName ] [ --help ]'$'\n'''$'\n''    --profile profileName  String. Optional. The credentials profile to remove.'$'\n''    --comments             Flag. Optional. Write comments to the credentials file (in addition to updating the record).'$'\n''    profileName            String. Optional. The credentials profile to remove.'$'\n''    --help                 Flag. Optional. Display this help.'$'\n'''$'\n''Remove credentials from the AWS credentials file'$'\n'''$'\n''If the AWS credentials file is not found, succeeds.'$'\n'''$'\n''You can supply the profile using the --profile or directly, but just one.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/aws.md"
