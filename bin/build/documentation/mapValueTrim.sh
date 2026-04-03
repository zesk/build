#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="mapFile - File. Required. a file containing bash environment definitions"$'\n'"value - String. Optional. One or more values to map using said environment file."$'\n'""
base="map.sh"
description="Maps a string using an environment file"$'\n'""
file="bin/build/tools/map.sh"
fn="mapValueTrim"
foundNames=([0]="argument")
rawComment="Maps a string using an environment file"$'\n'"Argument: mapFile - File. Required. a file containing bash environment definitions"$'\n'"Argument: value - String. Optional. One or more values to map using said environment file."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="4c91deb7564d353356e6832445db742dc8a696de"
summary="Maps a string using an environment file"
summaryComputed="true"
usage="mapValueTrim mapFile [ value ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmapValueTrim'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mmapFile'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mmapFile  '$'\e''[[(value)]mFile. Required. a file containing bash environment definitions'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvalue    '$'\e''[[(value)]mString. Optional. One or more values to map using said environment file.'$'\e''[[(reset)]m'$'\n'''$'\n''Maps a string using an environment file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mapValueTrim mapFile [ value ]'$'\n'''$'\n''    mapFile  File. Required. a file containing bash environment definitions'$'\n''    value    String. Optional. One or more values to map using said environment file.'$'\n'''$'\n''Maps a string using an environment file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
