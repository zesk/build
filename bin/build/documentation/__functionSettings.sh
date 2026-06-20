#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="home - Directory. BUILD_HOME"$'\n'"functionName - String. Function to fetch settings for"$'\n'"generatePath - Boolean. Optional. Pass in \`true\` to just generate the file path and *not* require the file to exist."$'\n'""
base="usage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Load cached function comment values"
descriptionLineCount=""
environment="BUILD_DOCUMENTATION_PATH"$'\n'""
file="bin/build/tools/usage.sh"
fn="__functionSettings"
fnMarker="__functionsettings"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="requires")
line="150"
original="__functionSettings"
rawComment="Summary: Load cached function comment values"$'\n'"Argument: home - Directory. BUILD_HOME"$'\n'"Argument: functionName - String. Function to fetch settings for"$'\n'"Argument: generatePath - Boolean. Optional. Pass in \`true\` to just generate the file path and *not* require the file to exist."$'\n'"Environment: BUILD_DOCUMENTATION_PATH"$'\n'"Requires: __documentationFile"$'\n'""$'\n'""
requires="__documentationFile"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="01b6c3e63321ac7c7af6eceb919864c8294945e5"
sourceLine="150"
summary="Load cached function comment values"
summaryComputed=""
usage="__functionSettings [ home ] [ functionName ] [ generatePath ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__functionSettings'$'\e''[0m '$'\e''[[(blue)]m[ home ]'$'\e''[0m '$'\e''[[(blue)]m[ functionName ]'$'\e''[0m '$'\e''[[(blue)]m[ generatePath ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mhome          '$'\e''[[(value)]mDirectory. BUILD_HOME'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfunctionName  '$'\e''[[(value)]mString. Function to fetch settings for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mgeneratePath  '$'\e''[[(value)]mBoolean. Optional. Pass in '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m to just generate the file path and '$'\e''[[(cyan)]mnot'$'\e''[[(reset)]m require the file to exist.'$'\e''[[(reset)]m'$'\n'''$'\n''Load cached function comment values'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DOCUMENTATION_PATH'
# shellcheck disable=SC2016
helpPlain='Usage: __functionSettings [ home ] [ functionName ] [ generatePath ]'$'\n'''$'\n''    home          Directory. BUILD_HOME'$'\n''    functionName  String. Function to fetch settings for'$'\n''    generatePath  Boolean. Optional. Pass in true to just generate the file path and not require the file to exist.'$'\n'''$'\n''Load cached function comment values'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DOCUMENTATION_PATH'
documentationPath="documentation/source/tools/internal.md"
