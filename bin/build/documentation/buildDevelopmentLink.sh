#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.\n--reset - Flag. Optional. Revert the link and reinstall using the original binary.\n'
base="developer.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Add a development link to the local version of Zesk Build for testing in local projects.\n\nCopies or updates `$BUILD_HOME/bin/build` in current project.\n\nUseful when you want to test a fix on a current project.\n\n'
descriptionLineCount="6"
file="bin/build/tools/developer.sh"
fn="buildDevelopmentLink"
fnMarker="builddevelopmentlink"
foundNames=([0]="argument")
line="181"
rawComment=$'Add a development link to the local version of Zesk Build for testing in local projects.\nCopies or updates `$BUILD_HOME/bin/build` in current project.\nUseful when you want to test a fix on a current project.\nArgument: --copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.\nArgument: --reset - Flag. Optional. Revert the link and reinstall using the original binary.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/developer.sh"
sourceHash="78a593214724db23edf7c0ae664f15c226343bbd"
sourceLine="181"
summary="Add a development link to the local version of Zesk"
summaryComputed="true"
usage="buildDevelopmentLink [ --copy ] [ --reset ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDevelopmentLink'$'\e''[0m '$'\e''[[(blue)]m[ --copy ]'$'\e''[0m '$'\e''[[(blue)]m[ --reset ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--copy   '$'\e''[[(value)]mFlag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--reset  '$'\e''[[(value)]mFlag. Optional. Revert the link and reinstall using the original binary.'$'\e''[[(reset)]m'$'\n'''$'\n''Add a development link to the local version of Zesk Build for testing in local projects.'$'\n'''$'\n''Copies or updates '$'\e''[[(code)]m$BUILD_HOME/bin/build'$'\e''[[(reset)]m in current project.'$'\n'''$'\n''Useful when you want to test a fix on a current project.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: buildDevelopmentLink [ --copy ] [ --reset ]'$'\n'''$'\n''    --copy   Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.'$'\n''    --reset  Flag. Optional. Revert the link and reinstall using the original binary.'$'\n'''$'\n''Add a development link to the local version of Zesk Build for testing in local projects.'$'\n'''$'\n''Copies or updates $BUILD_HOME/bin/build in current project.'$'\n'''$'\n''Useful when you want to test a fix on a current project.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/developer.md"
