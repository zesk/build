#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="mapFile - File. Required. a file containing bash environment definitions"$'\n'"value - String. Optional. One or more values to map using said environment file."$'\n'""
base="map.sh"
description="Maps a string using an environment file"$'\n'""$'\n'""$'\n'""
file="bin/build/tools/map.sh"
fn="mapValueTrim"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceModified="1768756695"
summary="Maps a string using an environment file"
usage="mapValueTrim mapFile [ value ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmapValueTrim[0m [38;2;255;255;0m[35;48;2;0;0;0mmapFile[0m[0m [94m[ value ][0m

    [31mmapFile  [1;97mFile. Required. a file containing bash environment definitions[0m
    [94mvalue    [1;97mString. Optional. One or more values to map using said environment file.[0m

Maps a string using an environment file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: mapValueTrim mapFile [ value ]

    mapFile  File. Required. a file containing bash environment definitions
    value    String. Optional. One or more values to map using said environment file.

Maps a string using an environment file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
