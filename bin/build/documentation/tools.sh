#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.\n--verbose - Flag. Optional. Be verbose.\n... - Callable. Optional. Run this command after loading in the current build context.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run a Zesk Build command or load it\n\n'
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="tools"
fnMarker="tools"
foundNames=([0]="argument")
line="474"
rawComment=$'Run a Zesk Build command or load it\nArgument: --help - Flag. Optional. Display this help.\nArgument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.\nArgument: --verbose - Flag. Optional. Be verbose.\nArgument: ... - Callable. Optional. Run this command after loading in the current build context.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="474"
summary="Run a Zesk Build command or load it"
summaryComputed="true"
usage="tools [ --help ] [ --start startDirectory ] [ --verbose ] [ ... ]"
