#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="deployHome - Directory. Required. Deployment database home."$'\n'""
base="deploy.sh"
description="Outputs the build target name which is based on the environment \`BUILD_TARGET\`."$'\n'"If this is called on a non-deployment system, use the application root instead of"$'\n'"\`deployHome\` for compatibility."$'\n'""
environment="BUILD_TARGET"$'\n'""
exitCode="0"
file="bin/build/tools/deploy.sh"
foundNames=([0]="argument" [1]="leak" [2]="environment")
leak="BUILD_TARGET"$'\n'""
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Outputs the build target name which is based on the environment \`BUILD_TARGET\`."$'\n'"If this is called on a non-deployment system, use the application root instead of"$'\n'"\`deployHome\` for compatibility."$'\n'"Leak: BUILD_TARGET"$'\n'"Environment: BUILD_TARGET"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Outputs the build target name which is based on the"
usage="deployPackageName deployHome"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdeployPackageName'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mdeployHome'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mdeployHome  '$'\e''[[value]mDirectory. Required. Deployment database home.'$'\e''[[reset]m'$'\n'''$'\n''Outputs the build target name which is based on the environment '$'\e''[[code]mBUILD_TARGET'$'\e''[[reset]m.'$'\n''If this is called on a non-deployment system, use the application root instead of'$'\n'''$'\e''[[code]mdeployHome'$'\e''[[reset]m for compatibility.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_TARGET'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployPackageName deployHome'$'\n'''$'\n''    deployHome  Directory. Required. Deployment database home.'$'\n'''$'\n''Outputs the build target name which is based on the environment BUILD_TARGET.'$'\n''If this is called on a non-deployment system, use the application root instead of'$'\n''deployHome for compatibility.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_TARGET'$'\n'''
