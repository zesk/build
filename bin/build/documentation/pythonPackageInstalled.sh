#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="pipPackage ... - String. Required. Package name(s) to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed."$'\n'""
base="python.sh"
description="Is a package installed for python?"$'\n'""
exitCode="0"
file="bin/build/tools/python.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Is a package installed for python?"$'\n'"Argument: pipPackage ... - String. Required. Package name(s) to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed."$'\n'"Return Code: 0 - All packages are installed (or at least one package with \`--any\`)"$'\n'"Return Code: 1 - All packages are not installed (or NO packages are installed with \`--any\`)"$'\n'""$'\n'""
return_code="0 - All packages are installed (or at least one package with \`--any\`)"$'\n'"1 - All packages are not installed (or NO packages are installed with \`--any\`)"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceModified="1769184734"
summary="Is a package installed for python?"
usage="pythonPackageInstalled pipPackage ... [ --help ] [ --handler handler ] [ --any ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mpythonPackageInstalled'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mpipPackage ...'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ --handler handler ]'$'\e''[0m '$'\e''[[blue]m[ --any ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mpipPackage ...     '$'\e''[[value]mString. Required. Package name(s) to check.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help             '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--handler handler  '$'\e''[[value]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--any              '$'\e''[[value]mFlag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed.'$'\e''[[reset]m'$'\n'''$'\n''Is a package installed for python?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - All packages are installed (or at least one package with '$'\e''[[code]m--any'$'\e''[[reset]m)'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - All packages are not installed (or NO packages are installed with '$'\e''[[code]m--any'$'\e''[[reset]m)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pythonPackageInstalled pipPackage ... [ --help ] [ --handler handler ] [ --any ]'$'\n'''$'\n''    pipPackage ...     String. Required. Package name(s) to check.'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --any              Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed.'$'\n'''$'\n''Is a package installed for python?'$'\n'''$'\n''Return codes:'$'\n''- 0 - All packages are installed (or at least one package with --any)'$'\n''- 1 - All packages are not installed (or NO packages are installed with --any)'$'\n'''
