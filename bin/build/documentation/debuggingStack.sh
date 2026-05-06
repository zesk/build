#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="-x - Flag. Optional. Show exported variables. (verbose)"$'\n'"--me - Flag. Optional. Show calling function call stack frame."$'\n'"--exit - Flag. Optional. Exit with code 0 after output."$'\n'""
base="dump.sh"
build_debug="debuggingStack - \`debuggingStack\` shows arguments passed (extra) and exports (optional flag) ALWAYS"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Dump the function and include stacks and the current environment"$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/dump.sh"
fn="debuggingStack"
fnMarker="debuggingstack"
foundNames=([0]="argument" [1]="requires" [2]="environment" [3]="build_debug")
line="18"
rawComment="Dump the function and include stacks and the current environment"$'\n'"Argument: -x - Flag. Optional. Show exported variables. (verbose)"$'\n'"Argument: --me - Flag. Optional. Show calling function call stack frame."$'\n'"Argument: --exit - Flag. Optional. Exit with code 0 after output."$'\n'"Requires: printf bashDocumentation"$'\n'"Environment: BUILD_DEBUG"$'\n'"BUILD_DEBUG: debuggingStack - \`debuggingStack\` shows arguments passed (extra) and exports (optional flag) ALWAYS"$'\n'"Requires: throwArgument"$'\n'""$'\n'""
requires="printf bashDocumentation"$'\n'"throwArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceHash="63d0b744477aa020f81137dccf35c889f1754a76"
sourceLine="18"
summary="Dump the function and include stacks and the current environment"
summaryComputed="true"
usage="debuggingStack [ -x ] [ --me ] [ --exit ]"
