#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="pipPackage ... - String. Required. Package name(s) to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed."$'\n'""
base="python.sh"
description="Is a package installed for python?"$'\n'"Return Code: 0 - All packages are installed (or at least one package with \`--any\`)"$'\n'"Return Code: 1 - All packages are not installed (or NO packages are installed with \`--any\`)"$'\n'""
file="bin/build/tools/python.sh"
fn="pythonPackageInstalled"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceModified="1768721469"
summary="Is a package installed for python?"
usage="pythonPackageInstalled pipPackage ... [ --help ] [ --handler handler ] [ --any ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpythonPackageInstalled[0m [38;2;255;255;0m[35;48;2;0;0;0mpipPackage ...[0m[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --any ][0m

    [31mpipPackage ...     [1;97mString. Required. Package name(s) to check.[0m
    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--any              [1;97mFlag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed.[0m

Is a package installed for python?
Return Code: 0 - All packages are installed (or at least one package with [38;2;0;255;0;48;2;0;0;0m--any[0m)
Return Code: 1 - All packages are not installed (or NO packages are installed with [38;2;0;255;0;48;2;0;0;0m--any[0m)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: pythonPackageInstalled pipPackage ... [ --help ] [ --handler handler ] [ --any ]

    pipPackage ...     String. Required. Package name(s) to check.
    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    --any              Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed.

Is a package installed for python?
Return Code: 0 - All packages are installed (or at least one package with --any)
Return Code: 1 - All packages are not installed (or NO packages are installed with --any)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
