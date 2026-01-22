#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="--application directory - Directory. Required. Path to project location."$'\n'"--require requirements - File. Optional. Requirements file for project."$'\n'"pipPackage ... - String. Optional. One or more pip packages to install in the virtual environment."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="python.sh"
description="Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them."$'\n'""$'\n'"When completed, a directory \`.venv\` exists in your project containing dependencies."$'\n'""
file="bin/build/tools/python.sh"
fn="pythonVirtual"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceModified="1769097744"
summary="Set up a virtual environment for a project and install"
usage="pythonVirtual --application directory [ --require requirements ] [ pipPackage ... ] [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpythonVirtual[0m [38;2;255;255;0m[35;48;2;0;0;0m--application directory[0m[0m [94m[ --require requirements ][0m [94m[ pipPackage ... ][0m [94m[ --help ][0m [94m[ --handler handler ][0m

    [31m--application directory  [1;97mDirectory. Required. Path to project location.[0m
    [94m--require requirements   [1;97mFile. Optional. Requirements file for project.[0m
    [94mpipPackage ...           [1;97mString. Optional. One or more pip packages to install in the virtual environment.[0m
    [94m--help                   [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler        [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m

Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them.

When completed, a directory [38;2;0;255;0;48;2;0;0;0m.venv[0m exists in your project containing dependencies.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: pythonVirtual --application directory [ --require requirements ] [ pipPackage ... ] [ --help ] [ --handler handler ]

    --application directory  Directory. Required. Path to project location.
    --require requirements   File. Optional. Requirements file for project.
    pipPackage ...           String. Optional. One or more pip packages to install in the virtual environment.
    --help                   Flag. Optional. Display this help.
    --handler handler        Function. Optional. Use this error handler instead of the default error handler.

Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them.

When completed, a directory .venv exists in your project containing dependencies.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
