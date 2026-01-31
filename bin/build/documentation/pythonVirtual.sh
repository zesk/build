#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="python.sh"
description="Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them."$'\n'"Argument: --application directory - Directory. Required. Path to project location."$'\n'"Argument: --require requirements - File. Optional. Requirements file for project."$'\n'"Argument: pipPackage ... - String. Optional. One or more pip packages to install in the virtual environment."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"When completed, a directory \`.venv\` exists in your project containing dependencies."$'\n'""
file="bin/build/tools/python.sh"
foundNames=()
rawComment="Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them."$'\n'"Argument: --application directory - Directory. Required. Path to project location."$'\n'"Argument: --require requirements - File. Optional. Requirements file for project."$'\n'"Argument: pipPackage ... - String. Optional. One or more pip packages to install in the virtual environment."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"When completed, a directory \`.venv\` exists in your project containing dependencies."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="c1e4cce2b3109ebc21697635fdb1e0bfb5cf244a"
summary="Set up a virtual environment for a project and install"
usage="pythonVirtual"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpythonVirtual'$'\e''[0m'$'\n'''$'\n''Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them.'$'\n''Argument: --application directory - Directory. Required. Path to project location.'$'\n''Argument: --require requirements - File. Optional. Requirements file for project.'$'\n''Argument: pipPackage ... - String. Optional. One or more pip packages to install in the virtual environment.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''When completed, a directory '$'\e''[[(code)]m.venv'$'\e''[[(reset)]m exists in your project containing dependencies.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pythonVirtual'$'\n'''$'\n''Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them.'$'\n''Argument: --application directory - Directory. Required. Path to project location.'$'\n''Argument: --require requirements - File. Optional. Requirements file for project.'$'\n''Argument: pipPackage ... - String. Optional. One or more pip packages to install in the virtual environment.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''When completed, a directory .venv exists in your project containing dependencies.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.623
