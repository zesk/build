#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="deploy.sh"
description="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Argument: versionName - String. Required. Application ID to look for"$'\n'"Get the previous version of the supplied version"$'\n'"Return Code: 1 - No version exists"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/deploy.sh"
foundNames=()
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Argument: versionName - String. Required. Application ID to look for"$'\n'"Get the previous version of the supplied version"$'\n'"Return Code: 1 - No version exists"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="a31b1bbd4c1948917bf8d67d421a1dfa3abe655d"
summary="Argument: deployHome - Directory. Required. Deployment database home."
usage="deployPreviousVersion"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployPreviousVersion'$'\e''[0m'$'\n'''$'\n''Argument: deployHome - Directory. Required. Deployment database home.'$'\n''Argument: versionName - String. Required. Application ID to look for'$'\n''Get the previous version of the supplied version'$'\n''Return Code: 1 - No version exists'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployPreviousVersion'$'\n'''$'\n''Argument: deployHome - Directory. Required. Deployment database home.'$'\n''Argument: versionName - String. Required. Application ID to look for'$'\n''Get the previous version of the supplied version'$'\n''Return Code: 1 - No version exists'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.481
