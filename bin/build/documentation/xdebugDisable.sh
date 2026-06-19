#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="xdebug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Disable Xdebug on systems that have it."$'\n'""$'\n'"This changes the value of \`XDEBUG_ENABLED\` to \`false\`. Programs must honor this and then skip invoking the debugger."$'\n'""$'\n'""
descriptionLineCount="4"
environment="XDEBUG_ENABLED"$'\n'""
file="bin/build/tools/xdebug.sh"
fn="xdebugDisable"
fnMarker="xdebugdisable"
foundNames=([0]="summary" [1]="environment" [2]="argument")
line="83"
rawComment="Summary: Disable Xdebug"$'\n'"Disable Xdebug on systems that have it."$'\n'"This changes the value of \`XDEBUG_ENABLED\` to \`false\`. Programs must honor this and then skip invoking the debugger."$'\n'"Environment: XDEBUG_ENABLED"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/xdebug.sh"
sourceHash="d783e70f3766fcf2b5ebe80af81390390fe99322"
sourceLine="83"
summary="Disable Xdebug"
summaryComputed=""
usage="xdebugDisable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mxdebugDisable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Disable Xdebug on systems that have it.'$'\n'''$'\n''This changes the value of '$'\e''[[(code)]mXDEBUG_ENABLED'$'\e''[[(reset)]m to '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m. Programs must honor this and then skip invoking the debugger.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDEBUG_ENABLED'
# shellcheck disable=SC2016
helpPlain='Usage: xdebugDisable [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Disable Xdebug on systems that have it.'$'\n'''$'\n''This changes the value of XDEBUG_ENABLED to false. Programs must honor this and then skip invoking the debugger.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDEBUG_ENABLED'
documentationPath="documentation/source/tools/xdebug.md"
