#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
depends="-"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Returns whether the shell has the debugging flag set"$'\n'""$'\n'"Useful if you need to temporarily enable or disable it."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/debug.sh"
fn="isBashDebug"
fnMarker="isbashdebug"
foundNames=([0]="depends")
line="123"
rawComment="Returns whether the shell has the debugging flag set"$'\n'"Useful if you need to temporarily enable or disable it."$'\n'"Depends: -"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="20094ded2fe440d8caa5368a60b92d19047e793c"
sourceLine="123"
summary="Returns whether the shell has the debugging flag set"
summaryComputed="true"
usage="isBashDebug"
