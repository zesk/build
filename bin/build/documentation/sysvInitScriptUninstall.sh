#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="sysvinit.sh"
description="Remove an initialization script"$'\n'"Argument: binary - String. Required. Basename of installed script to remove."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/sysvinit.sh"
foundNames=()
rawComment="Remove an initialization script"$'\n'"Argument: binary - String. Required. Basename of installed script to remove."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sysvinit.sh"
sourceHash="e64c6fa1ae04f7475888437756536aedff1dfaf8"
summary="Remove an initialization script"
usage="sysvInitScriptUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]msysvInitScriptUninstall'$'\e''[0m'$'\n'''$'\n''Remove an initialization script'$'\n''Argument: binary - String. Required. Basename of installed script to remove.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: sysvInitScriptUninstall'$'\n'''$'\n''Remove an initialization script'$'\n''Argument: binary - String. Required. Basename of installed script to remove.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.623
