#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="-x -  Flag. Optional.Show exported variables. (verbose)"$'\n'"--me -  Flag. Optional.Show calling function call stack frame."$'\n'"--exit -  Flag. Optional.Exit with code 0 after output."$'\n'""
base="dump.sh"
build_debug="debuggingStack - \`debuggingStack\` shows arguments passed (extra) and exports (optional flag) ALWAYS"$'\n'""
description="Dump the function and include stacks and the current environment"$'\n'""
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/dump.sh"
fn="debuggingStack"
foundNames=([0]="argument" [1]="requires" [2]="environment" [3]="build_debug")
requires="printf usageDocument"$'\n'"throwArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/dump.sh"
sourceModified="1768683825"
summary="Dump the function and include stacks and the current environment"
usage="debuggingStack [ -x ] [ --me ] [ --exit ]"
