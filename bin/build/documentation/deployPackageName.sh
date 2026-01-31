#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="deploy.sh"
description="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Outputs the build target name which is based on the environment \`BUILD_TARGET\`."$'\n'"If this is called on a non-deployment system, use the application root instead of"$'\n'"\`deployHome\` for compatibility."$'\n'"Leak: BUILD_TARGET"$'\n'"Environment: BUILD_TARGET"$'\n'""
file="bin/build/tools/deploy.sh"
foundNames=()
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Outputs the build target name which is based on the environment \`BUILD_TARGET\`."$'\n'"If this is called on a non-deployment system, use the application root instead of"$'\n'"\`deployHome\` for compatibility."$'\n'"Leak: BUILD_TARGET"$'\n'"Environment: BUILD_TARGET"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="a31b1bbd4c1948917bf8d67d421a1dfa3abe655d"
summary="Argument: deployHome - Directory. Required. Deployment database home."
usage="deployPackageName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployPackageName'$'\e''[0m'$'\n'''$'\n''Argument: deployHome - Directory. Required. Deployment database home.'$'\n''Outputs the build target name which is based on the environment '$'\e''[[(code)]mBUILD_TARGET'$'\e''[[(reset)]m.'$'\n''If this is called on a non-deployment system, use the application root instead of'$'\n'''$'\e''[[(code)]mdeployHome'$'\e''[[(reset)]m for compatibility.'$'\n''Leak: BUILD_TARGET'$'\n''Environment: BUILD_TARGET'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployPackageName'$'\n'''$'\n''Argument: deployHome - Directory. Required. Deployment database home.'$'\n''Outputs the build target name which is based on the environment BUILD_TARGET.'$'\n''If this is called on a non-deployment system, use the application root instead of'$'\n''deployHome for compatibility.'$'\n''Leak: BUILD_TARGET'$'\n''Environment: BUILD_TARGET'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.47
