#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/developer.sh"
argument="--copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization."$'\n'"--reset - Flag. Optional. Revert the link and reinstall using the original binary."$'\n'""
base="developer.sh"
description="Add a development link to the local version of Zesk Build for testing in local projects."$'\n'"Copies or updates \`\$BUILD_HOME/bin/build\` in current project."$'\n'"Useful when you want to test a fix on a current project."$'\n'""
exitCode="0"
file="bin/build/tools/developer.sh"
foundNames=([0]="argument")
rawComment="Add a development link to the local version of Zesk Build for testing in local projects."$'\n'"Copies or updates \`\$BUILD_HOME/bin/build\` in current project."$'\n'"Useful when you want to test a fix on a current project."$'\n'"Argument: --copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization."$'\n'"Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184734"
summary="Add a development link to the local version of Zesk"
usage="buildDevelopmentLink [ --copy ] [ --reset ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mbuildDevelopmentLink'$'\e''[0m '$'\e''[[blue]m[ --copy ]'$'\e''[0m '$'\e''[[blue]m[ --reset ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--copy   '$'\e''[[value]mFlag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--reset  '$'\e''[[value]mFlag. Optional. Revert the link and reinstall using the original binary.'$'\e''[[reset]m'$'\n'''$'\n''Add a development link to the local version of Zesk Build for testing in local projects.'$'\n''Copies or updates '$'\e''[[code]m$BUILD_HOME/bin/build'$'\e''[[reset]m in current project.'$'\n''Useful when you want to test a fix on a current project.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildDevelopmentLink [ --copy ] [ --reset ]'$'\n'''$'\n''    --copy   Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.'$'\n''    --reset  Flag. Optional. Revert the link and reinstall using the original binary.'$'\n'''$'\n''Add a development link to the local version of Zesk Build for testing in local projects.'$'\n''Copies or updates $BUILD_HOME/bin/build in current project.'$'\n''Useful when you want to test a fix on a current project.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
