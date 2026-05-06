#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="mapFile - File. Required. a file containing bash environment definitions"$'\n'"value - String. Optional. One or more values to map using said environment file."$'\n'""
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Maps a string using an environment file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/map.sh"
fn="mapValueTrim"
fnMarker="mapvaluetrim"
foundNames=([0]="argument")
line="229"
rawComment="Maps a string using an environment file"$'\n'"Argument: mapFile - File. Required. a file containing bash environment definitions"$'\n'"Argument: value - String. Optional. One or more values to map using said environment file."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="940f9ebf8bd346b36b369627516a0d1367a6cdfa"
sourceLine="229"
summary="Maps a string using an environment file"
summaryComputed="true"
usage="mapValueTrim mapFile [ value ]"
