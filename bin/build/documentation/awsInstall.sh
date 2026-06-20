#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'aws Command-Line install\n\nInstalls x86 or aarch64 binary based on `HOSTTYPE`.\n\n'
descriptionLineCount="4"
file="bin/build/tools/aws.sh"
fn="awsInstall"
fnMarker="awsinstall"
foundNames=([0]="requires")
line="30"
original="awsInstall"
rawComment=$'aws Command-Line install\nInstalls x86 or aarch64 binary based on `HOSTTYPE`.\nRequires: packageInstall urlFetch\n\n'
requires=$'packageInstall urlFetch\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/aws.sh"
sourceHash="9d4ed3ead974a5078fada208dc2c1f1e7d157af7"
sourceLine="30"
summary="aws Command-Line install"
summaryComputed="true"
usage="awsInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsInstall'$'\e''[0m'$'\n'''$'\n''aws Command-Line install'$'\n'''$'\n''Installs x86 or aarch64 binary based on '$'\e''[[(code)]mHOSTTYPE'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: awsInstall'$'\n'''$'\n''aws Command-Line install'$'\n'''$'\n''Installs x86 or aarch64 binary based on HOSTTYPE.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/aws.md"
