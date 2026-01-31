#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="map.sh"
description="Maps a string using an environment file"$'\n'"Argument: mapFile - File. Required. a file containing bash environment definitions"$'\n'"Argument: value - String. Optional. One or more values to map using said environment file."$'\n'""
file="bin/build/tools/map.sh"
foundNames=()
rawComment="Maps a string using an environment file"$'\n'"Argument: mapFile - File. Required. a file containing bash environment definitions"$'\n'"Argument: value - String. Optional. One or more values to map using said environment file."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="f0c857d63d28b28b6a1200dec8c23530ae6c78d6"
summary="Maps a string using an environment file"
usage="mapValueTrim"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmapValueTrim'$'\e''[0m'$'\n'''$'\n''Maps a string using an environment file'$'\n''Argument: mapFile - File. Required. a file containing bash environment definitions'$'\n''Argument: value - String. Optional. One or more values to map using said environment file.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mapValueTrim'$'\n'''$'\n''Maps a string using an environment file'$'\n''Argument: mapFile - File. Required. a file containing bash environment definitions'$'\n''Argument: value - String. Optional. One or more values to map using said environment file.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.45
