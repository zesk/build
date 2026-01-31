#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="python.sh"
description="Utility to install python dependencies via pip"$'\n'"Installs python if it hasn't been using \`pythonInstall\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: pipPackage [ ... ] - String. Required. Pip package name to install."$'\n'""
file="bin/build/tools/python.sh"
foundNames=()
rawComment="Utility to install python dependencies via pip"$'\n'"Installs python if it hasn't been using \`pythonInstall\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: pipPackage [ ... ] - String. Required. Pip package name to install."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="c1e4cce2b3109ebc21697635fdb1e0bfb5cf244a"
summary="Utility to install python dependencies via pip"
usage="pipInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpipInstall'$'\e''[0m'$'\n'''$'\n''Utility to install python dependencies via pip'$'\n''Installs python if it hasn'\''t been using '$'\e''[[(code)]mpythonInstall'$'\e''[[(reset)]m.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: pipPackage [ ... ] - String. Required. Pip package name to install.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pipInstall'$'\n'''$'\n''Utility to install python dependencies via pip'$'\n''Installs python if it hasn'\''t been using pythonInstall.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: pipPackage [ ... ] - String. Required. Pip package name to install.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.464
