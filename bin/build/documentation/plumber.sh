#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="command ... - Callable. Command to run"$'\n'"--temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"--leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="debug.sh"
build_debug="plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""
description="Run command and detect any global or local leaks"$'\n'""
file="bin/build/tools/debug.sh"
fn="plumber"
foundNames=([0]="requires" [1]="argument" [2]="build_debug")
requires="declare diff grep"$'\n'"throwArgument decorate usageArgumentString isCallable"$'\n'"fileTemporaryName removeFields"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/debug.sh"
sourceModified="1768695708"
summary="Run command and detect any global or local leaks"
usage="plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]"
