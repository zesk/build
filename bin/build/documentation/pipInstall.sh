#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"pipPackage [ ... ] - String. Required. Pip package name to install."$'\n'""
base="python.sh"
description="Utility to install python dependencies via pip"$'\n'"Installs python if it hasn't been using \`pythonInstall\`."$'\n'""
file="bin/build/tools/python.sh"
fn="pipInstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceModified="1769097744"
summary="Utility to install python dependencies via pip"
usage="pipInstall [ --help ] [ --handler handler ] pipPackage [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpipInstall[0m [94m[ --help ][0m [94m[ --handler handler ][0m [38;2;255;255;0m[35;48;2;0;0;0mpipPackage [ ... ][0m[0m

    [94m--help              [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler   [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [31mpipPackage [ ... ]  [1;97mString. Required. Pip package name to install.[0m

Utility to install python dependencies via pip
Installs python if it hasn'\''t been using [38;2;0;255;0;48;2;0;0;0mpythonInstall[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: pipInstall [ --help ] [ --handler handler ] pipPackage [ ... ]

    --help              Flag. Optional. Display this help.
    --handler handler   Function. Optional. Use this error handler instead of the default error handler.
    pipPackage [ ... ]  String. Required. Pip package name to install.

Utility to install python dependencies via pip
Installs python if it hasn'\''t been using pythonInstall.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
