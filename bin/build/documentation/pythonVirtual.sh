#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="--application directory - Directory. Required. Path to project location."$'\n'"--require requirements - File. Optional. Requirements file for project."$'\n'"pipPackage ... - String. Optional. One or more pip packages to install in the virtual environment."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="python.sh"
description="Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them."$'\n'""$'\n'"When completed, a directory \`.venv\` exists in your project containing dependencies."$'\n'""
file="bin/build/tools/python.sh"
fn="pythonVirtual"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/python.sh"
sourceModified="1768721469"
summary="Set up a virtual environment for a project and install"
usage="pythonVirtual --application directory [ --require requirements ] [ pipPackage ... ] [ --help ] [ --handler handler ]"
