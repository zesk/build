#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'""
base="debug.sh"
description="Start build debugging if it is enabled."$'\n'"This does \`set -x\` which traces and outputs every shell command"$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'""$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'"Example:     buildDebugStart || :"$'\n'""
environment="BUILD_DEBUG"$'\n'""
example="    # ... complex code here"$'\n'"    buildDebugStop || :. -"$'\n'""
file="bin/build/tools/debug.sh"
fn="buildDebugStart"
requires="buildDebugEnabled"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769059754"
summary="Start build debugging if it is enabled."
usage="buildDebugStart [ moduleName ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildDebugStart[0m [94m[ moduleName ][0m

    [94mmoduleName  [1;97mString. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.[0m

Start build debugging if it is enabled.
This does [38;2;0;255;0;48;2;0;0;0mset -x[0m which traces and outputs every shell command
Use it to debug when you can not figure out what is happening internally.

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m can be a list of strings like [38;2;0;255;0;48;2;0;0;0menvironment,assert[0m for example.
Example:     buildDebugStart || :

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

Example:
    # ... complex code here
    buildDebugStop || :. -
'
# shellcheck disable=SC2016
helpPlain='Usage: buildDebugStart [ moduleName ]

    moduleName  String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.

Start build debugging if it is enabled.
This does set -x which traces and outputs every shell command
Use it to debug when you can not figure out what is happening internally.

BUILD_DEBUG can be a list of strings like environment,assert for example.
Example:     buildDebugStart || :

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

Example:
    # ... complex code here
    buildDebugStop || :. -
'
