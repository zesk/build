#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="applicationPath - Directory. Required. Application target path."$'\n'""
base="deploy.sh"
description="Safe application deployment by moving"$'\n'"Deploy current application to target path"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployMove"
foundNames=([0]="argument")
line="192"
lowerFn="deploymove"
rawComment="Safe application deployment by moving"$'\n'"Argument: applicationPath - Directory. Required. Application target path."$'\n'"Deploy current application to target path"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="9800c80d1e803796230e87b8fd398df05b0442b9"
sourceLine="192"
summary="Safe application deployment by moving"
summaryComputed="true"
usage="deployMove applicationPath"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployMove'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mapplicationPath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mapplicationPath  '$'\e''[[(value)]mDirectory. Required. Application target path.'$'\e''[[(reset)]m'$'\n'''$'\n''Safe application deployment by moving'$'\n''Deploy current application to target path'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployMove applicationPath'$'\n'''$'\n''    applicationPath  Directory. Required. Application target path.'$'\n'''$'\n''Safe application deployment by moving'$'\n''Deploy current application to target path'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/deploy.md"
