#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tofu.sh"
argument="package - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
description="Uninstall tofu binary and apt sources keys"$'\n'""$'\n'""
file="bin/build/tools/tofu.sh"
fn="tofuUninstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="tofuInstall packageUninstall"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceModified="1769063211"
summary="Uninstall tofu binary and apt sources keys"
usage="tofuUninstall [ package ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtofuUninstall[0m [94m[ package ][0m [94m[ --help ][0m

    [94mpackage  [1;97mString. Optional. Additional packages to uninstall using [38;2;0;255;0;48;2;0;0;0mpackageUninstall[0m[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m

Uninstall tofu binary and apt sources keys

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: tofuUninstall [ package ] [ --help ]

    package  String. Optional. Additional packages to uninstall using packageUninstall
    --help   Flag. Optional. Display this help.

Uninstall tofu binary and apt sources keys

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
