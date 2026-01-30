#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="none"
base="bitbucket.sh"
description="Are we currently in the BitBucket pipeline?"$'\n'""
file="bin/build/tools/bitbucket.sh"
foundNames=([0]="return_code")
rawComment="Are we currently in the BitBucket pipeline?"$'\n'"Return Code: 0 - is BitBucket pipeline"$'\n'"Return Code: 1 - Not a BitBucket pipeline"$'\n'""$'\n'""
return_code="0 - is BitBucket pipeline"$'\n'"1 - Not a BitBucket pipeline"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="b18640e190031212dc11fff000dc05f4173167ac"
summary="Are we currently in the BitBucket pipeline?"
usage="isBitBucketPipeline"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBitBucketPipeline'$'\e''[0m'$'\n'''$'\n''Are we currently in the BitBucket pipeline?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - is BitBucket pipeline'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Not a BitBucket pipeline'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isBitBucketPipeline'$'\n'''$'\n''Are we currently in the BitBucket pipeline?'$'\n'''$'\n''Return codes:'$'\n''- 0 - is BitBucket pipeline'$'\n''- 1 - Not a BitBucket pipeline'$'\n'''
# elapsed 0.461
