#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Prints the build home directory (usually same as the application root)"$'\n'""
environment="BUILD_HOME"$'\n'""
file="bin/build/tools/build.sh"
fn="buildHome"
foundNames=([0]="environment" [1]="argument")
line="152"
lowerFn="buildhome"
rawComment="Environment: BUILD_HOME"$'\n'"Prints the build home directory (usually same as the application root)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="36d6620f5e7ef50da4732294ca63c0ba7d07b1f4"
sourceLine="152"
summary="Prints the build home directory (usually same as the application"
summaryComputed="true"
usage="buildHome [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildHome'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Prints the build home directory (usually same as the application root)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOME'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildHome [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Prints the build home directory (usually same as the application root)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOME'$'\n'''
documentationPath="documentation/source/tools/build.md"
