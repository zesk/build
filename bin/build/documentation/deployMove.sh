#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="deploy.sh"
description="Safe application deployment by moving"$'\n'"Argument: applicationPath - Directory. Required. Application target path."$'\n'"Deploy current application to target path"$'\n'""
file="bin/build/tools/deploy.sh"
foundNames=()
rawComment="Safe application deployment by moving"$'\n'"Argument: applicationPath - Directory. Required. Application target path."$'\n'"Deploy current application to target path"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="a31b1bbd4c1948917bf8d67d421a1dfa3abe655d"
summary="Safe application deployment by moving"
usage="deployMove"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployMove'$'\e''[0m'$'\n'''$'\n''Safe application deployment by moving'$'\n''Argument: applicationPath - Directory. Required. Application target path.'$'\n''Deploy current application to target path'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployMove'$'\n'''$'\n''Safe application deployment by moving'$'\n''Argument: applicationPath - Directory. Required. Application target path.'$'\n''Deploy current application to target path'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.479
