#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="command - Callable. Required. Thing to muzzle."$'\n'"... - Arguments. Optional. Additional arguments."$'\n'""
base="sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Suppress stdout without piping. Handy when you just want a behavior not the output."$'\n'""$'\n'""
descriptionLineCount="2"
example="    muzzle pushd \"\$buildDir\""$'\n'"    catchEnvironment \"\$handler\" phpBuild || returnUndo \$? muzzle popd || return \$?"$'\n'""
file="bin/build/tools/sugar.sh"
fn="muzzle"
fnMarker="muzzle"
foundNames=([0]="argument" [1]="example" [2]="stdout")
line="53"
rawComment="Suppress stdout without piping. Handy when you just want a behavior not the output."$'\n'"Argument: command - Callable. Required. Thing to muzzle."$'\n'"Argument: ... - Arguments. Optional. Additional arguments."$'\n'"Example:     {fn} pushd \"\$buildDir\""$'\n'"Example:     catchEnvironment \"\$handler\" phpBuild || returnUndo \$? {fn} popd || return \$?"$'\n'"stdout: - No output from stdout ever from this function"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="e8338cd30cac46f1f4725c84ca79d511b7921f72"
sourceLine="53"
stdout="- No output from stdout ever from this function"$'\n'""
summary="Suppress stdout without piping. Handy when you just want a"
summaryComputed="true"
usage="muzzle command [ ... ]"
