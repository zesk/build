#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="deployHome - Directory. Required. Deployment database home."$'\n'"versionName - String. Required. Application ID to look for"$'\n'""
base="deploy.sh"
description="Does a deploy version exist? versionName is the version identifier for deployments"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployHasVersion"
foundNames=([0]="argument")
line="123"
lowerFn="deployhasversion"
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Argument: versionName - String. Required. Application ID to look for"$'\n'"Does a deploy version exist? versionName is the version identifier for deployments"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="9800c80d1e803796230e87b8fd398df05b0442b9"
sourceLine="123"
summary="Does a deploy version exist? versionName is the version identifier"
summaryComputed="true"
usage="deployHasVersion deployHome versionName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployHasVersion'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdeployHome'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mversionName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdeployHome   '$'\e''[[(value)]mDirectory. Required. Deployment database home.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mversionName  '$'\e''[[(value)]mString. Required. Application ID to look for'$'\e''[[(reset)]m'$'\n'''$'\n''Does a deploy version exist? versionName is the version identifier for deployments'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployHasVersion deployHome versionName'$'\n'''$'\n''    deployHome   Directory. Required. Deployment database home.'$'\n''    versionName  String. Required. Application ID to look for'$'\n'''$'\n''Does a deploy version exist? versionName is the version identifier for deployments'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/deploy.md"
