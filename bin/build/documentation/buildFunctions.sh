#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--deprecated - Flag. Optional. Include all deprecated functions as well."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Prints the list of functions defined in Zesk Build"$'\n'""
environment="BUILD_HOME"$'\n'""
file="bin/build/tools/build.sh"
foundNames=([0]="argument" [1]="environment")
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --deprecated - Flag. Optional. Include all deprecated functions as well."$'\n'"Environment: BUILD_HOME"$'\n'"Prints the list of functions defined in Zesk Build"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Prints the list of functions defined in Zesk Build"
summaryComputed="true"
usage="buildFunctions [ --help ] [ --deprecated ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildFunctions'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --deprecated ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--deprecated  '$'\e''[[(value)]mFlag. Optional. Include all deprecated functions as well.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Prints the list of functions defined in Zesk Build'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOME'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildFunctions [ --help ] [ --deprecated ] [ --help ]'$'\n'''$'\n''    --help        Flag. Optional. Display this help.'$'\n''    --deprecated  Flag. Optional. Include all deprecated functions as well.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Prints the list of functions defined in Zesk Build'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOME'$'\n'''
