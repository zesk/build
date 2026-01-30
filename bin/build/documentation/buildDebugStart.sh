#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'""
base="debug.sh"
description="Start build debugging if it is enabled."$'\n'"This does \`set -x\` which traces and outputs every shell command"$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'"Example:     buildDebugStart || :"$'\n'""
environment="BUILD_DEBUG"$'\n'""
example="    # ... complex code here"$'\n'"    buildDebugStop || :. -"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="environment" [1]="argument" [2]="example" [3]="requires")
rawComment="Start build debugging if it is enabled."$'\n'"This does \`set -x\` which traces and outputs every shell command"$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'"Environment: BUILD_DEBUG"$'\n'"Argument: moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'"Example:     buildDebugStart || :"$'\n'"Example:     # ... complex code here"$'\n'"Example:     buildDebugStop || :. -"$'\n'"Requires: buildDebugEnabled"$'\n'""$'\n'""
requires="buildDebugEnabled"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="f288b9b3b91991d05bd6676a6b9ef73b9e0296b8"
summary="Start build debugging if it is enabled."
usage="buildDebugStart [ moduleName ]"
