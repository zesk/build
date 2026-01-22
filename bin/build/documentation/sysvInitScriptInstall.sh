#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sysvinit.sh"
argument="binary - String. Required. Binary to install at startup."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="sysvinit.sh"
description="Install a script to run upon initialization."$'\n'""
file="bin/build/tools/sysvinit.sh"
fn="sysvInitScriptInstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sysvinit.sh"
sourceModified="1769063211"
summary="Install a script to run upon initialization."
usage="sysvInitScriptInstall binary [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255msysvInitScriptInstall[0m [38;2;255;255;0m[35;48;2;0;0;0mbinary[0m[0m [94m[ --help ][0m

    [31mbinary  [1;97mString. Required. Binary to install at startup.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Install a script to run upon initialization.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: sysvInitScriptInstall binary [ --help ]

    binary  String. Required. Binary to install at startup.
    --help  Flag. Optional. Display this help.

Install a script to run upon initialization.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
