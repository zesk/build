#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="bitbucket.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Are we currently in the BitBucket pipeline?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bitbucket.sh"
fn="isBitBucketPipeline"
fnMarker="isbitbucketpipeline"
foundNames=([0]="return_code")
line="84"
rawComment="Are we currently in the BitBucket pipeline?"$'\n'"Return Code: 0 - is BitBucket pipeline"$'\n'"Return Code: 1 - Not a BitBucket pipeline"$'\n'""$'\n'""
return_code="0 - is BitBucket pipeline"$'\n'"1 - Not a BitBucket pipeline"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="1f4c241b99592c40a01d7716c3276a12de251352"
sourceLine="84"
summary="Are we currently in the BitBucket pipeline?"
summaryComputed="true"
usage="isBitBucketPipeline"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBitBucketPipeline'$'\e''[0m'$'\n'''$'\n''Are we currently in the BitBucket pipeline?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - is BitBucket pipeline'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Not a BitBucket pipeline'
# shellcheck disable=SC2016
helpPlain='Usage: isBitBucketPipeline'$'\n'''$'\n''Are we currently in the BitBucket pipeline?'$'\n'''$'\n''Return codes:'$'\n''- 0 - is BitBucket pipeline'$'\n''- 1 - Not a BitBucket pipeline'
documentationPath="documentation/source/tools/bitbucket.md"
