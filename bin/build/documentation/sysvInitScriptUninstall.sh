#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="binary - String. Required. Basename of installed script to remove."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="sysvinit.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove an initialization script"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/sysvinit.sh"
fn="sysvInitScriptUninstall"
fnMarker="sysvinitscriptuninstall"
foundNames=([0]="argument")
line="63"
rawComment="Remove an initialization script"$'\n'"Argument: binary - String. Required. Basename of installed script to remove."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sysvinit.sh"
sourceHash="bb5016783f56b496121eaa750da489ad966faee3"
sourceLine="63"
summary="Remove an initialization script"
summaryComputed="true"
usage="sysvInitScriptUninstall binary [ --help ]"
