#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'mapFile - File. Required. a file containing bash environment definitions\nvalue - String. Optional. One or more values to map using said environment file.\n'
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Maps a string using an environment file\n\n'
descriptionLineCount="2"
file="bin/build/tools/map.sh"
fn="mapValueTrim"
fnMarker="mapvaluetrim"
foundNames=([0]="argument")
line="229"
rawComment=$'Maps a string using an environment file\nArgument: mapFile - File. Required. a file containing bash environment definitions\nArgument: value - String. Optional. One or more values to map using said environment file.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/map.sh"
sourceHash="ad239b6bc25f5b8d6c7ef606feeaa9161fae799e"
sourceLine="229"
summary="Maps a string using an environment file"
summaryComputed="true"
usage="mapValueTrim mapFile [ value ]"
