#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'name - String. Required. The log file name to create. Trims leading `_` if present.\n--no-create - Flag. Optional. Do not require creation of the directory where the log file will appear.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate the path for a quiet log in the build cache directory, creating it if necessary.\n\n'
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="buildQuietLog"
fnMarker="buildquietlog"
foundNames=([0]="argument")
line="639"
rawComment=$'Generate the path for a quiet log in the build cache directory, creating it if necessary.\nArgument: name - String. Required. The log file name to create. Trims leading `_` if present.\nArgument: --no-create - Flag. Optional. Do not require creation of the directory where the log file will appear.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="639"
summary="Generate the path for a quiet log in the build"
summaryComputed="true"
usage="buildQuietLog name [ --no-create ]"
