#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Output the list of environment variable names which can be loaded via \`buildEnvironmentLoad\` or \`buildEnvironmentGet\`"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentNames"
foundNames=([0]="argument" [1]="requires")
requires="convertValue _buildEnvironmentPath find sort read __help catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/build.sh"
sourceModified="1768721469"
summary="Output the list of environment variable names which can be"
usage="buildEnvironmentNames [ --help ]"
