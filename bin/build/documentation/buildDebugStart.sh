#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
    # ... complex code here
    # Debugging: 51b581e9a1275e3801165068bceaa6d245c76c2c
applicationFile="bin/build/tools/debug.sh"
argument="moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'""
base="debug.sh"
description="Start build debugging if it is enabled."$'\n'"This does \`set -x\` which traces and outputs every shell command"$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'""$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'"Example:     buildDebugStart || :"$'\n'""
environment="BUILD_DEBUG"$'\n'""
example="    # ... complex code here"$'\n'"    buildDebugStop || :. -"$'\n'"    # Debugging: 51b581e9a1275e3801165068bceaa6d245c76c2c"$'\n'""
file="bin/build/tools/debug.sh"
fn="buildDebugStart"
foundNames=([0]="environment" [1]="argument" [2]="example" [3]="requires")
requires="buildDebugEnabled"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/debug.sh"
sourceModified="1768759254"
summary="Start build debugging if it is enabled."
usage="buildDebugStart [ moduleName ]"
