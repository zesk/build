#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bitbucket.sh"
description="Are we currently in the BitBucket pipeline?"$'\n'"shellcheck disable=SC2120"$'\n'""
file="bin/build/tools/bitbucket.sh"
foundNames=([0]="return_code")
rawComment="Are we currently in the BitBucket pipeline?"$'\n'"Return Code: 0 - is BitBucket pipeline"$'\n'"Return Code: 1 - Not a BitBucket pipeline"$'\n'"shellcheck disable=SC2120"$'\n'""$'\n'""
return_code="0 - is BitBucket pipeline"$'\n'"1 - Not a BitBucket pipeline"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="4a421c2dcbbf58af3dd11352be2e5851420ecd17"
summary="Are we currently in the BitBucket pipeline?"
summaryComputed="true"
usage="isBitBucketPipeline"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBitBucketPipeline'$'\e''[0m'$'\n'''$'\n''Are we currently in the BitBucket pipeline?'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - is BitBucket pipeline'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Not a BitBucket pipeline'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isBitBucketPipeline'$'\n'''$'\n''Are we currently in the BitBucket pipeline?'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - is BitBucket pipeline'$'\n''- [[(code)]m1[[(reset)]m - Not a BitBucket pipeline'$'\n'''
# elapsed 3.635
