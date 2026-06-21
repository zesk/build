#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'No documentation for `__validateTypeAWSRegion`.\n'
descriptionLineCount=""
file="bin/build/tools/aws.sh"
fn="__validateTypeAWSRegion"
fnMarker="__validatetypeawsregion"
foundNames=([0]="requires")
line="428"
original="__validateTypeAWSRegion"
rawComment=$'Requires: awsRegionValid _validateThrow\n\n'
requires=$'awsRegionValid _validateThrow\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/aws.sh"
sourceHash="9d4ed3ead974a5078fada208dc2c1f1e7d157af7"
sourceLine="428"
summary="undocumented"
summaryComputed=""
usage="__validateTypeAWSRegion"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeAWSRegion'$'\e''[0m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]m__validateTypeAWSRegion'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeAWSRegion'$'\n'''$'\n''No documentation for __validateTypeAWSRegion.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
