#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="packageName - A simple package name which will be expanded to specific platform or package-manager specific package names"$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""
base="package.sh"
description="No documentation for \`packageMapping\`."$'\n'""
file="bin/build/tools/package.sh"
fn="packageMapping"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1769063211"
summary="undocumented"
usage="packageMapping [ packageName ] [ --manager packageManager ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageMapping[0m [94m[ packageName ][0m [94m[ --manager packageManager ][0m

    [94mpackageName               [1;97mA simple package name which will be expanded to specific platform or package-manager specific package names[0m
    [94m--manager packageManager  [1;97mString. Optional. Package manager to use. (apk, apt, brew)[0m

No documentation for [38;2;0;255;0;48;2;0;0;0mpackageMapping[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: packageMapping [ packageName ] [ --manager packageManager ]

    packageName               A simple package name which will be expanded to specific platform or package-manager specific package names
    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)

No documentation for packageMapping.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
