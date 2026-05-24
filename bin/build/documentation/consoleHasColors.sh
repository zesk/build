#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate\n\n'
descriptionLineCount="2"
environment=$'BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.\n'
file="bin/build/tools/decorate/core.sh"
fn="consoleHasColors"
fnMarker="consolehascolors"
foundNames=([0]="argument" [1]="return_code" [2]="environment" [3]="requires")
line="16"
rawComment=$'Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - Console or output supports colors\nReturn Code: 1 - Colors are likely not supported by console\nEnvironment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.\nRequires: isPositiveInteger tput helpArgument convertValue\n\n'
requires=$'isPositiveInteger tput helpArgument convertValue\n'
return_code=$'0 - Console or output supports colors\n1 - Colors are likely not supported by console\n'
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="e4cbe4eab5673d871026d759c95b8accc63d09fa"
sourceLine="16"
summary="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\`"
summaryComputed="true"
usage="consoleHasColors [ --help ]"
