#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="--maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"--skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"--show-skipped - Flag. Show skipped environment variables."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="dump.sh"
description="Output the environment shamelessly (not secure, not recommended)"$'\n'""$'\n'""
file="bin/build/tools/dump.sh"
fn="dumpEnvironmentUnsafe"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/dump.sh"
sourceModified="1768683825"
summary="Output the environment shamelessly (not secure, not recommended)"
usage="dumpEnvironmentUnsafe [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --help ]"
