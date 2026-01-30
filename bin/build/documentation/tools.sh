#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"... - Callable. Optional. Run this command after loading in the current build context."$'\n'""
base="build.sh"
description="Run a Zesk Build command or load it"$'\n'""
file="bin/build/tools/build.sh"
foundNames=([0]="argument")
rawComment="Run a Zesk Build command or load it"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: ... - Callable. Optional. Run this command after loading in the current build context."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="b2a2dc0e900e3d8b3cd1add71cdd4b5c8c37bcdf"
summary="Run a Zesk Build command or load it"
usage="tools [ --help ] [ --start startDirectory ] [ --verbose ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtools'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --start startDirectory ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--start startDirectory  '$'\e''[[(value)]mDirectory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose               '$'\e''[[(value)]mFlag. Optional. Be verbose.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...                     '$'\e''[[(value)]mCallable. Optional. Run this command after loading in the current build context.'$'\e''[[(reset)]m'$'\n'''$'\n''Run a Zesk Build command or load it'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tools [[(blue)]m[ --help ] [[(blue)]m[ --start startDirectory ] [[(blue)]m[ --verbose ] [[(blue)]m[ ... ]'$'\n'''$'\n''    [[(blue)]m--help                  Flag. Optional. Display this help.'$'\n''    [[(blue)]m--start startDirectory  Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.'$'\n''    [[(blue)]m--verbose               Flag. Optional. Be verbose.'$'\n''    [[(blue)]m...                     Callable. Optional. Run this command after loading in the current build context.'$'\n'''$'\n''Run a Zesk Build command or load it'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 2.707
