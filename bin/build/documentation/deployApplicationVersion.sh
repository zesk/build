#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="applicationHome - Directory. Required. Application home to get the version from."$'\n'""
base="deploy.sh"
description="Extracts version from an application either from \`.deploy\` files or from the the \`.env\` if"$'\n'"that does not exist."$'\n'"Checks \`APPLICATION_ID\` and \`APPLICATION_TAG\` and uses first non-blank value."$'\n'""
file="bin/build/tools/deploy.sh"
foundNames=([0]="argument")
rawComment="Argument: applicationHome - Directory. Required. Application home to get the version from."$'\n'"Extracts version from an application either from \`.deploy\` files or from the the \`.env\` if"$'\n'"that does not exist."$'\n'"Checks \`APPLICATION_ID\` and \`APPLICATION_TAG\` and uses first non-blank value."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="a31b1bbd4c1948917bf8d67d421a1dfa3abe655d"
summary="Extracts version from an application either from \`.deploy\` files or"
usage="deployApplicationVersion applicationHome"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployApplicationVersion'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mapplicationHome'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mapplicationHome  '$'\e''[[(value)]mDirectory. Required. Application home to get the version from.'$'\e''[[(reset)]m'$'\n'''$'\n''Extracts version from an application either from '$'\e''[[(code)]m.deploy'$'\e''[[(reset)]m files or from the the '$'\e''[[(code)]m.env'$'\e''[[(reset)]m if'$'\n''that does not exist.'$'\n''Checks '$'\e''[[(code)]mAPPLICATION_ID'$'\e''[[(reset)]m and '$'\e''[[(code)]mAPPLICATION_TAG'$'\e''[[(reset)]m and uses first non-blank value.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployApplicationVersion applicationHome'$'\n'''$'\n''    applicationHome  Directory. Required. Application home to get the version from.'$'\n'''$'\n''Extracts version from an application either from .deploy files or from the the .env if'$'\n''that does not exist.'$'\n''Checks APPLICATION_ID and APPLICATION_TAG and uses first non-blank value.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.534
