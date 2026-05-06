#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--application directory - Directory. Required. Path to project location."$'\n'"--require requirements - File. Optional. Requirements file for project."$'\n'"pipPackage ... - String. Optional. One or more pip packages to install in the virtual environment."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="python.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them."$'\n'""$'\n'"When completed, a directory \`.venv\` exists in your project containing dependencies."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/python.sh"
fn="pythonVirtual"
fnMarker="pythonvirtual"
foundNames=([0]="argument")
line="300"
rawComment="Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them."$'\n'"Argument: --application directory - Directory. Required. Path to project location."$'\n'"Argument: --require requirements - File. Optional. Requirements file for project."$'\n'"Argument: pipPackage ... - String. Optional. One or more pip packages to install in the virtual environment."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"When completed, a directory \`.venv\` exists in your project containing dependencies."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="c5956e3d32ee75e52908b4d36d8cfde5928066e8"
sourceLine="300"
summary="Set up a virtual environment for a project and install"
summaryComputed="true"
usage="pythonVirtual --application directory [ --require requirements ] [ pipPackage ... ] [ --help ] [ --handler handler ]"
