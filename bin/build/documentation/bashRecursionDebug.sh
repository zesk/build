#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--end - Flag. Optional. Stop testing for recursion."$'\n'""
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Place this in code where you suspect an infinite loop occurs"$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'""$'\n'""
descriptionLineCount="4"
environment="__BUILD_RECURSION"$'\n'""
file="bin/build/tools/debug.sh"
fn="bashRecursionDebug"
fnMarker="bashrecursiondebug"
foundNames=([0]="argument" [1]="requires" [2]="environment")
line="139"
rawComment="Place this in code where you suspect an infinite loop occurs"$'\n'"It will fail upon a second call; to reset call with \`--end\`"$'\n'"Argument: --end - Flag. Optional. Stop testing for recursion."$'\n'"When called twice, fails on the second invocation and dumps a call stack to stderr."$'\n'"Requires: printf unset  export debuggingStack exit"$'\n'"Environment: __BUILD_RECURSION"$'\n'""$'\n'""
requires="printf unset  export debuggingStack exit"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="20094ded2fe440d8caa5368a60b92d19047e793c"
sourceLine="139"
summary="Place this in code where you suspect an infinite loop"
summaryComputed="true"
usage="bashRecursionDebug [ --end ]"
