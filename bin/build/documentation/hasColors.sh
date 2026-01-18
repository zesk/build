#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decorate.sh"
argument="--help - Flag. Optional.Display this help."$'\n'""
base="decorate.sh"
description="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\` to calculate"$'\n'""$'\n'"Return Code: 0 - Console or output supports colors"$'\n'"Return Code: 1 - Colors are likely not supported by console"$'\n'""
environment="BUILD_COLORS - Boolean. Optional.Whether the build system will output ANSI colors."$'\n'""
file="bin/build/tools/decorate.sh"
fn="hasColors"
foundNames=([0]="argument" [1]="environment" [2]="requires")
requires="isPositiveInteger tput"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/decorate.sh"
sourceModified="1768695708"
summary="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\`"
usage="hasColors [ --help ]"
