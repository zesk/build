#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="xdebug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install the xdebug PHP Debugger using `pear` and `pecl`.\n\n'
descriptionLineCount="2"
file="bin/build/tools/xdebug.sh"
fn="xdebugInstall"
fnMarker="xdebuginstall"
foundNames=([0]="summary" [1]="argument")
line="19"
original="xdebugInstall"
rawComment=$'Summary: Install the xdebug PHP Debugger\nInstall the xdebug PHP Debugger using `pear` and `pecl`.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/xdebug.sh"
sourceHash="d783e70f3766fcf2b5ebe80af81390390fe99322"
sourceLine="19"
summary="Install the xdebug PHP Debugger"
summaryComputed=""
usage="xdebugInstall [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mxdebugInstall'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Install the xdebug PHP Debugger using '$'\e''[[(code)]mpear'$'\e''[[(reset)]m and '$'\e''[[(code)]mpecl'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: xdebugInstall [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Install the xdebug PHP Debugger using pear and pecl.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/xdebug.md"
