#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="deployHome - Directory. Required. Deployment database home."$'\n'"applicationPath - Directory. Required. Application target path."$'\n'""
base="deploy.sh"
description="Automatically convert application deployments using non-links to links."$'\n'""
exitCode="0"
file="bin/build/tools/deploy.sh"
foundNames=([0]="argument")
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Argument: applicationPath - Directory. Required. Application target path."$'\n'"Automatically convert application deployments using non-links to links."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Automatically convert application deployments using non-links to links."
usage="deployMigrateDirectoryToLink deployHome applicationPath"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdeployMigrateDirectoryToLink'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mdeployHome'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mapplicationPath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mdeployHome       '$'\e''[[value]mDirectory. Required. Deployment database home.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mapplicationPath  '$'\e''[[value]mDirectory. Required. Application target path.'$'\e''[[reset]m'$'\n'''$'\n''Automatically convert application deployments using non-links to links.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployMigrateDirectoryToLink deployHome applicationPath'$'\n'''$'\n''    deployHome       Directory. Required. Deployment database home.'$'\n''    applicationPath  Directory. Required. Application target path.'$'\n'''$'\n''Automatically convert application deployments using non-links to links.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
