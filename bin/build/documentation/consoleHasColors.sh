#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\` to calculate"$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors."$'\n'""
file="bin/build/tools/decorate/core.sh"
fn="consoleHasColors"
fnMarker="consolehascolors"
foundNames=([0]="argument" [1]="return_code" [2]="environment" [3]="requires")
line="16"
rawComment="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\` to calculate"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Console or output supports colors"$'\n'"Return Code: 1 - Colors are likely not supported by console"$'\n'"Environment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors."$'\n'"Requires: isPositiveInteger tput helpArgument convertValue"$'\n'""$'\n'""
requires="isPositiveInteger tput helpArgument convertValue"$'\n'""
return_code="0 - Console or output supports colors"$'\n'"1 - Colors are likely not supported by console"$'\n'""
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="4288b1b5dd74b1f4240bb03c3728be0a51c51aa6"
sourceLine="16"
summary="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\`"
summaryComputed="true"
usage="consoleHasColors [ --help ]"
