#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="command ... - Callable. Command to run"$'\n'"--temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"--leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="debug.sh"
build_debug="plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run command and detect any global or local leaks"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/debug.sh"
fn="plumber"
fnMarker="plumber"
foundNames=([0]="requires" [1]="argument" [2]="build_debug")
line="298"
rawComment="Run command and detect any global or local leaks"$'\n'"Requires: declare diff grep"$'\n'"Requires: throwArgument decorate usageArgumentString isCallable"$'\n'"Requires: fileTemporaryName textRemoveFields"$'\n'"Argument: command ... - Callable. Command to run"$'\n'"Argument: --temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"Argument: --leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"BUILD_DEBUG: plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""$'\n'""
requires="declare diff grep"$'\n'"throwArgument decorate usageArgumentString isCallable"$'\n'"fileTemporaryName textRemoveFields"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="20094ded2fe440d8caa5368a60b92d19047e793c"
sourceLine="298"
summary="Run command and detect any global or local leaks"
summaryComputed="true"
usage="plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]"
