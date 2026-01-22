#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sysvinit.sh"
argument="binary - String. Required. Basename of installed script to remove."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="sysvinit.sh"
description="Remove an initialization script"$'\n'""
file="bin/build/tools/sysvinit.sh"
fn="sysvInitScriptUninstall"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sysvinit.sh"
sourceModified="1768721470"
summary="Remove an initialization script"
usage="sysvInitScriptUninstall binary [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255msysvInitScriptUninstall[0m [38;2;255;255;0m[35;48;2;0;0;0mbinary[0m[0m [94m[ --help ][0m

    [31mbinary  [1;97mString. Required. Basename of installed script to remove.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Remove an initialization script

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: sysvInitScriptUninstall binary [ --help ]

    binary  String. Required. Basename of installed script to remove.
    --help  Flag. Optional. Display this help.

Remove an initialization script

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
