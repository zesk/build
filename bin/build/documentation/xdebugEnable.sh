#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="xdebug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Enable Xdebug on systems that have it.\n\nThis changes the value of `XDEBUG_ENABLED` to `true`. Programs must honor this and invoke the debugger.\n\n'
descriptionLineCount="4"
environment=$'XDEBUG_ENABLED\n'
file="bin/build/tools/xdebug.sh"
fn="xdebugEnable"
fnMarker="xdebugenable"
foundNames=([0]="summary" [1]="environment" [2]="argument")
line="62"
rawComment=$'Summary: Enable Xdebug\nEnable Xdebug on systems that have it.\nThis changes the value of `XDEBUG_ENABLED` to `true`. Programs must honor this and invoke the debugger.\nEnvironment: XDEBUG_ENABLED\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/xdebug.sh"
sourceHash="7f9e2ea2b3b9a370ead8571ef15416ec1291d14d"
sourceLine="62"
summary="Enable Xdebug"
summaryComputed=""
usage="xdebugEnable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mxdebugEnable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Enable Xdebug on systems that have it.'$'\n'''$'\n''This changes the value of '$'\e''[[(code)]mXDEBUG_ENABLED'$'\e''[[(reset)]m to '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m. Programs must honor this and invoke the debugger.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDEBUG_ENABLED'
# shellcheck disable=SC2016
helpPlain='Usage: xdebugEnable [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Enable Xdebug on systems that have it.'$'\n'''$'\n''This changes the value of XDEBUG_ENABLED to true. Programs must honor this and invoke the debugger.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDEBUG_ENABLED'
documentationPath="documentation/source/tools/xdebug.md"
