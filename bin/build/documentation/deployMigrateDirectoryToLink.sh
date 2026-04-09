#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="deployHome - Directory. Required. Deployment database home."$'\n'"applicationPath - Directory. Required. Application target path."$'\n'""
base="deploy.sh"
description="Automatically convert application deployments using non-links to links."$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployMigrateDirectoryToLink"
foundNames=([0]="argument")
line="248"
lowerFn="deploymigratedirectorytolink"
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Argument: applicationPath - Directory. Required. Application target path."$'\n'"Automatically convert application deployments using non-links to links."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="5a5eadb87fbfbe1607e28405b9f8a9b51d2cc067"
sourceLine="248"
summary="Automatically convert application deployments using non-links to links."
summaryComputed="true"
usage="deployMigrateDirectoryToLink deployHome applicationPath"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployMigrateDirectoryToLink'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdeployHome'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mapplicationPath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdeployHome       '$'\e''[[(value)]mDirectory. Required. Deployment database home.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mapplicationPath  '$'\e''[[(value)]mDirectory. Required. Application target path.'$'\e''[[(reset)]m'$'\n'''$'\n''Automatically convert application deployments using non-links to links.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployMigrateDirectoryToLink deployHome applicationPath'$'\n'''$'\n''    deployHome       Directory. Required. Deployment database home.'$'\n''    applicationPath  Directory. Required. Application target path.'$'\n'''$'\n''Automatically convert application deployments using non-links to links.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/deploy.md"
