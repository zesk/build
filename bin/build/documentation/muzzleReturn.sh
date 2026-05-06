#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="command - Callable. Required. Thing to muzzle."$'\n'"... - Arguments. Optional. Additional arguments."$'\n'""
base="sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Suppress return code without piping. Handy when using diff to generate text"$'\n'""$'\n'""
descriptionLineCount="2"
example="    muzzleReturn diff -U0 \"\$buildDir\""$'\n'""
file="bin/build/tools/sugar.sh"
fn="muzzleReturn"
fnMarker="muzzlereturn"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="return_code")
line="69"
rawComment="Summary: Suppress return codes"$'\n'"Suppress return code without piping. Handy when using diff to generate text"$'\n'"Argument: command - Callable. Required. Thing to muzzle."$'\n'"Argument: ... - Arguments. Optional. Additional arguments."$'\n'"Example:     {fn} diff -U0 \"\$buildDir\""$'\n'"Return Code: 0 - Always"$'\n'""$'\n'""
return_code="0 - Always"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="e8338cd30cac46f1f4725c84ca79d511b7921f72"
sourceLine="69"
summary="Suppress return codes"
summaryComputed=""
usage="muzzleReturn command [ ... ]"
