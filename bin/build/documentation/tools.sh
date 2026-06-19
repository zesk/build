#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
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
line="496"
rawComment=$'Run a Zesk Build command or load it\nArgument: --help - Flag. Optional. Display this help.\nArgument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.\nArgument: --verbose - Flag. Optional. Be verbose.\nArgument: ... - Callable. Optional. Run this command after loading in the current build context.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="d8ce2a61cda62a4ee857835d348af45ba012bbb2"
sourceLine="496"
summary="Run a Zesk Build command or load it"
summaryComputed="true"
usage="tools [ --help ] [ --start startDirectory ] [ --verbose ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtools'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --start startDirectory ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--start startDirectory  '$'\e''[[(value)]mDirectory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose               '$'\e''[[(value)]mFlag. Optional. Be verbose.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...                     '$'\e''[[(value)]mCallable. Optional. Run this command after loading in the current build context.'$'\e''[[(reset)]m'$'\n'''$'\n''Run a Zesk Build command or load it'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: tools [ --help ] [ --start startDirectory ] [ --verbose ] [ ... ]'$'\n'''$'\n''    --help                  Flag. Optional. Display this help.'$'\n''    --start startDirectory  Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.'$'\n''    --verbose               Flag. Optional. Be verbose.'$'\n''    ...                     Callable. Optional. Run this command after loading in the current build context.'$'\n'''$'\n''Run a Zesk Build command or load it'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/build.md"
