#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="name - String. Required. The log file name to create. Trims leading \`_\` if present."$'\n'"--no-create - Flag. Optional. Do not require creation of the directory where the log file will appear."$'\n'""
base="build.sh"
description="Generate the path for a quiet log in the build cache directory, creating it if necessary."$'\n'""$'\n'""
file="bin/build/tools/build.sh"
fn="buildQuietLog"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/build.sh"
sourceModified="1768721469"
summary="Generate the path for a quiet log in the build"
usage="buildQuietLog name [ --no-create ]"
