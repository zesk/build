#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="deployHome - Directory. Required. Deployment database home."$'\n'"versionName - String. Required. Application ID to look for"$'\n'""
base="deploy.sh"
description="Get the previous version of the supplied version"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployPreviousVersion"
foundNames=([0]="argument" [1]="return_code")
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Argument: versionName - String. Required. Application ID to look for"$'\n'"Get the previous version of the supplied version"$'\n'"Return Code: 1 - No version exists"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="1 - No version exists"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="0dba533d3c624acbe70f69b4a92b652fb25d40d4"
summary="Get the previous version of the supplied version"
summaryComputed="true"
usage="deployPreviousVersion deployHome versionName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployPreviousVersion'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdeployHome'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mversionName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdeployHome   '$'\e''[[(value)]mDirectory. Required. Deployment database home.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mversionName  '$'\e''[[(value)]mString. Required. Application ID to look for'$'\e''[[(reset)]m'$'\n'''$'\n''Get the previous version of the supplied version'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No version exists'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployPreviousVersion deployHome versionName'$'\n'''$'\n''    deployHome   Directory. Required. Deployment database home.'$'\n''    versionName  String. Required. Application ID to look for'$'\n'''$'\n''Get the previous version of the supplied version'$'\n'''$'\n''Return codes:'$'\n''- 1 - No version exists'$'\n''- 2 - Argument error'$'\n'''
