#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="python.sh"
description="Is a package installed for python?"$'\n'"Argument: pipPackage ... - String. Required. Package name(s) to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed."$'\n'"Return Code: 0 - All packages are installed (or at least one package with \`--any\`)"$'\n'"Return Code: 1 - All packages are not installed (or NO packages are installed with \`--any\`)"$'\n'""
file="bin/build/tools/python.sh"
foundNames=()
rawComment="Is a package installed for python?"$'\n'"Argument: pipPackage ... - String. Required. Package name(s) to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed."$'\n'"Return Code: 0 - All packages are installed (or at least one package with \`--any\`)"$'\n'"Return Code: 1 - All packages are not installed (or NO packages are installed with \`--any\`)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="c1e4cce2b3109ebc21697635fdb1e0bfb5cf244a"
summary="Is a package installed for python?"
usage="pythonPackageInstalled"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpythonPackageInstalled'$'\e''[0m'$'\n'''$'\n''Is a package installed for python?'$'\n''Argument: pipPackage ... - String. Required. Package name(s) to check.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: --any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed.'$'\n''Return Code: 0 - All packages are installed (or at least one package with '$'\e''[[(code)]m--any'$'\e''[[(reset)]m)'$'\n''Return Code: 1 - All packages are not installed (or NO packages are installed with '$'\e''[[(code)]m--any'$'\e''[[(reset)]m)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pythonPackageInstalled'$'\n'''$'\n''Is a package installed for python?'$'\n''Argument: pipPackage ... - String. Required. Package name(s) to check.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: --any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed.'$'\n''Return Code: 0 - All packages are installed (or at least one package with --any)'$'\n''Return Code: 1 - All packages are not installed (or NO packages are installed with --any)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.514
