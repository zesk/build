#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'binary - String. Required. Basename of installed script to remove.\n--help - Flag. Optional. Display this help.\n'
base="sysvinit.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove an initialization script\n\n'
descriptionLineCount="2"
file="bin/build/tools/sysvinit.sh"
fn="sysvInitScriptUninstall"
fnMarker="sysvinitscriptuninstall"
foundNames=([0]="argument")
line="63"
rawComment=$'Remove an initialization script\nArgument: binary - String. Required. Basename of installed script to remove.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/sysvinit.sh"
sourceHash="8b64fe9c65c6406488145c36a870ea94f48c8f79"
sourceLine="63"
summary="Remove an initialization script"
summaryComputed="true"
usage="sysvInitScriptUninstall binary [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]msysvInitScriptUninstall'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbinary  '$'\e''[[(value)]mString. Required. Basename of installed script to remove.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove an initialization script'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: sysvInitScriptUninstall binary [ --help ]'$'\n'''$'\n''    binary  String. Required. Basename of installed script to remove.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Remove an initialization script'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sysvinit.md"
