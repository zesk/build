#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="path.sh"
description="Show the path and where binaries are found"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: binary - Executable. Optional. Display where this executable appears in the path."$'\n'""
file="bin/build/tools/path.sh"
foundNames=()
rawComment="Show the path and where binaries are found"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: binary - Executable. Optional. Display where this executable appears in the path."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/path.sh"
sourceHash="8a081a9a1154d0671a3f695f37287f54f605e380"
summary="Show the path and where binaries are found"
usage="pathShow"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpathShow'$'\e''[0m'$'\n'''$'\n''Show the path and where binaries are found'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: binary - Executable. Optional. Display where this executable appears in the path.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pathShow'$'\n'''$'\n''Show the path and where binaries are found'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: binary - Executable. Optional. Display where this executable appears in the path.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.506
