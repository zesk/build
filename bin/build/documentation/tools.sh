#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="build.sh"
description="Run a Zesk Build command or load it"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: ... - Callable. Optional. Run this command after loading in the current build context."$'\n'""
file="bin/build/tools/build.sh"
foundNames=()
rawComment="Run a Zesk Build command or load it"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: ... - Callable. Optional. Run this command after loading in the current build context."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Run a Zesk Build command or load it"
usage="tools"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtools'$'\e''[0m'$'\n'''$'\n''Run a Zesk Build command or load it'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.'$'\n''Argument: --verbose - Flag. Optional. Be verbose.'$'\n''Argument: ... - Callable. Optional. Run this command after loading in the current build context.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tools'$'\n'''$'\n''Run a Zesk Build command or load it'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.'$'\n''Argument: --verbose - Flag. Optional. Be verbose.'$'\n''Argument: ... - Callable. Optional. Run this command after loading in the current build context.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.886
