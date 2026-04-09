#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="binary - String. Required. Basename of installed script to remove."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="sysvinit.sh"
description="Remove an initialization script"$'\n'""
file="bin/build/tools/sysvinit.sh"
fn="sysvInitScriptUninstall"
foundNames=([0]="argument")
line="63"
lowerFn="sysvinitscriptuninstall"
rawComment="Remove an initialization script"$'\n'"Argument: binary - String. Required. Basename of installed script to remove."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sysvinit.sh"
sourceHash="bb5016783f56b496121eaa750da489ad966faee3"
sourceLine="63"
summary="Remove an initialization script"
summaryComputed="true"
usage="sysvInitScriptUninstall binary [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]msysvInitScriptUninstall'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbinary  '$'\e''[[(value)]mString. Required. Basename of installed script to remove.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove an initialization script'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: sysvInitScriptUninstall binary [ --help ]'$'\n'''$'\n''    binary  String. Required. Basename of installed script to remove.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Remove an initialization script'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/sysvinit.md"
