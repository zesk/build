#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'applicationPath - Directory. Required. Application target path.\n'
base="deploy.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Safe application deployment by moving\n\nDeploy current application to target path\n\n'
descriptionLineCount="4"
file="bin/build/tools/deploy.sh"
fn="deployMove"
fnMarker="deploymove"
foundNames=([0]="argument")
line="192"
rawComment=$'Safe application deployment by moving\nArgument: applicationPath - Directory. Required. Application target path.\nDeploy current application to target path\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/deploy.sh"
sourceHash="e0d57c87cddcd626993066f2fbdabd8666252165"
sourceLine="192"
summary="Safe application deployment by moving"
summaryComputed="true"
usage="deployMove applicationPath"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployMove'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mapplicationPath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mapplicationPath  '$'\e''[[(value)]mDirectory. Required. Application target path.'$'\e''[[(reset)]m'$'\n'''$'\n''Safe application deployment by moving'$'\n'''$'\n''Deploy current application to target path'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: deployMove applicationPath'$'\n'''$'\n''    applicationPath  Directory. Required. Application target path.'$'\n'''$'\n''Safe application deployment by moving'$'\n'''$'\n''Deploy current application to target path'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/deploy.md"
