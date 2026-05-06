#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="xdebug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Enable Xdebug on systems that have it"$'\n'""$'\n'""
descriptionLineCount="2"
environment="XDEBUG_ENABLED"$'\n'""
file="bin/build/tools/xdebug.sh"
fn="xdebugEnable"
fnMarker="xdebugenable"
foundNames=([0]="environment" [1]="argument")
line="54"
rawComment="Enable Xdebug on systems that have it"$'\n'"Environment: XDEBUG_ENABLED"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/xdebug.sh"
sourceHash="2fc83b70f12c5979d5fb5d8f25133b769c1fa267"
sourceLine="54"
summary="Enable Xdebug on systems that have it"
summaryComputed="true"
usage="xdebugEnable [ --help ]"
