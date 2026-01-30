#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--end - Flag. Optional. Stop testing for recursion."$'\n'""
base="debug.sh"
description="Place this in code where you suspect an infinite loop occurs"$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'""
environment="__BUILD_RECURSION"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="argument" [1]="requires" [2]="environment")
rawComment="Place this in code where you suspect an infinite loop occurs"$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"Argument: --end - Flag. Optional. Stop testing for recursion."$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'"Requires: printf unset  export debuggingStack exit"$'\n'"Environment: __BUILD_RECURSION"$'\n'""$'\n'""
requires="printf unset  export debuggingStack exit"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="f288b9b3b91991d05bd6676a6b9ef73b9e0296b8"
summary="Place this in code where you suspect an infinite loop"
usage="bashRecursionDebug [ --end ]"
