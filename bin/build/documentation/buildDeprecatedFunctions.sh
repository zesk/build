#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-31
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
sourceHash="7c3aa107c357db74a0d854defdaf7f2b17361d34"
sourceLine="65"
stdout=$'String\n'
summary="List all functions which are currently deprecated in Zesk Build"
summaryComputed="true"
usage="buildDeprecatedFunctions [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDeprecatedFunctions'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List all functions which are currently deprecated in Zesk Build'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''String'
# shellcheck disable=SC2016
helpPlain='Usage: buildDeprecatedFunctions [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List all functions which are currently deprecated in Zesk Build'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String'
documentationPath="documentation/source/tools/build.md"
