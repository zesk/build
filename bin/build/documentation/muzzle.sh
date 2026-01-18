#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="command - Callable. Required. Thing to muzzle."$'\n'"... - Arguments. Optional.Additional arguments."$'\n'""
base="sugar.sh"
description="Suppress stdout without piping. Handy when you just want a behavior not the output."$'\n'""
example="    muzzle pushd \"\$buildDir\""$'\n'"    catchEnvironment \"\$handler\" phpBuild || returnUndo \$? muzzle popd || return \$?"$'\n'""
file="bin/build/tools/sugar.sh"
fn="muzzle"
foundNames=([0]="argument" [1]="example" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/sugar.sh"
sourceModified="1768695708"
stdout="- No output from stdout ever from this function"$'\n'""
summary="Suppress stdout without piping. Handy when you just want a"
usage="muzzle command [ ... ]"
