#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-17
# shellcheck disable=SC2034
argument="--maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"--skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"--show-skipped - Flag. Show skipped environment variables."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="dump.sh"
description="Output the environment shamelessly (not secure, not recommended)"$'\n'""
file="bin/build/tools/dump.sh"
fn="dumpEnvironmentUnsafe"
foundNames=([0]="argument")
rawComment="Output the environment shamelessly (not secure, not recommended)"$'\n'"Argument: --maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"Argument: --skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"Argument: --show-skipped - Flag. Show skipped environment variables."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceHash="cbad93d332115968b7f4983bd2f33b00d702f214"
summary="Output the environment shamelessly (not secure, not recommended)"
summaryComputed="true"
usage="dumpEnvironmentUnsafe [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='no helpPlain in bin/build/documentation/dumpEnvironmentUnsafe.sh'$'\n'''
# shellcheck disable=SC2016
helpPlain='no helpPlain in bin/build/documentation/dumpEnvironmentUnsafe.sh'$'\n'''
