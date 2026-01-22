#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="package - String. Required. One or more packages to check if they are installed"$'\n'""
base="package.sh"
description="Is a package installed?"$'\n'"Return Code: 1 - If any packages are not installed"$'\n'"Return Code: 0 - All packages are installed"$'\n'""
file="bin/build/tools/package.sh"
fn="packageIsInstalled"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Is a package installed?"
usage="packageIsInstalled package"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageIsInstalled[0m [38;2;255;255;0m[35;48;2;0;0;0mpackage[0m[0m

    [31mpackage  [1;97mString. Required. One or more packages to check if they are installed[0m

Is a package installed?
Return Code: 1 - If any packages are not installed
Return Code: 0 - All packages are installed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: packageIsInstalled package

    package  String. Required. One or more packages to check if they are installed

Is a package installed?
Return Code: 1 - If any packages are not installed
Return Code: 0 - All packages are installed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
