#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'""
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Start build debugging if it is enabled."$'\n'"This does \`set -x\` which traces and outputs every shell command"$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'""$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'"Example:     buildDebugStart || :"$'\n'""$'\n'""
descriptionLineCount="7"
environment="BUILD_DEBUG"$'\n'""
example="    # ... complex code here"$'\n'"    buildDebugStop || :. -"$'\n'""
file="bin/build/tools/debug.sh"
fn="buildDebugStart"
fnMarker="builddebugstart"
foundNames=([0]="environment" [1]="argument" [2]="example" [3]="requires")
line="88"
rawComment="Start build debugging if it is enabled."$'\n'"This does \`set -x\` which traces and outputs every shell command"$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'"Environment: BUILD_DEBUG"$'\n'"Argument: moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'"Example:     buildDebugStart || :"$'\n'"Example:     # ... complex code here"$'\n'"Example:     buildDebugStop || :. -"$'\n'"Requires: buildDebugEnabled"$'\n'""$'\n'""
requires="buildDebugEnabled"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="20094ded2fe440d8caa5368a60b92d19047e793c"
sourceLine="88"
summary="Start build debugging if it is enabled."
summaryComputed="true"
usage="buildDebugStart [ moduleName ]"
