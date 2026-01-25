#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bitbucket.sh"
argument="none"
base="bitbucket.sh"
description="Are we currently in the BitBucket pipeline?"$'\n'""
exitCode="0"
file="bin/build/tools/bitbucket.sh"
foundNames=([0]="return_code")
rawComment="Are we currently in the BitBucket pipeline?"$'\n'"Return Code: 0 - is BitBucket pipeline"$'\n'"Return Code: 1 - Not a BitBucket pipeline"$'\n'""$'\n'""
return_code="0 - is BitBucket pipeline"$'\n'"1 - Not a BitBucket pipeline"$'\n'""
sourceModified="1769063211"
summary="Are we currently in the BitBucket pipeline?"
usage="isBitBucketPipeline"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]misBitBucketPipeline'$'\e''[0m'$'\n'''$'\n''Are we currently in the BitBucket pipeline?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - is BitBucket pipeline'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Not a BitBucket pipeline'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isBitBucketPipeline'$'\n'''$'\n''Are we currently in the BitBucket pipeline?'$'\n'''$'\n''Return codes:'$'\n''- 0 - is BitBucket pipeline'$'\n''- 1 - Not a BitBucket pipeline'$'\n'''
