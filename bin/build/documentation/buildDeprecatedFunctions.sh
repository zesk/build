#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List all functions which are currently deprecated in Zesk Build\n\n'
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="buildDeprecatedFunctions"
fnMarker="builddeprecatedfunctions"
foundNames=([0]="stdout" [1]="argument")
line="65"
rawComment=$'List all functions which are currently deprecated in Zesk Build\nstdout: String\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="65"
stdout=$'String\n'
summary="List all functions which are currently deprecated in Zesk Build"
summaryComputed="true"
usage="buildDeprecatedFunctions [ --help ]"
