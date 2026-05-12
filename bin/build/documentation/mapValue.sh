#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\nmapFile - File. Required. a file containing bash environment definitions\nvalue - String. Optional. One or more values to map using said environment file\n--prefix - String. Optional. Token prefix defaults to `{`.\n--suffix - String. Optional. Token suffix defaults to `}`.\n--search-filter - Zero or more. Callable. Filter for search tokens. (e.g. `stringLowercase`)\n--replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. `textTrim`)\n'
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Maps a string using an environment file\n\n'
descriptionLineCount="2"
file="bin/build/tools/map.sh"
fn="mapValue"
fnMarker="mapvalue"
foundNames=([0]="argument")
line="152"
rawComment=$'Maps a string using an environment file\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: mapFile - File. Required. a file containing bash environment definitions\nArgument: value - String. Optional. One or more values to map using said environment file\nArgument: --prefix - String. Optional. Token prefix defaults to `{`.\nArgument: --suffix - String. Optional. Token suffix defaults to `}`.\nArgument: --search-filter - Zero or more. Callable. Filter for search tokens. (e.g. `stringLowercase`)\nArgument: --replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. `textTrim`)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/map.sh"
sourceHash="ad239b6bc25f5b8d6c7ef606feeaa9161fae799e"
sourceLine="152"
summary="Maps a string using an environment file"
summaryComputed="true"
usage="mapValue [ --help ] [ --handler handler ] mapFile [ value ] [ --prefix ] [ --suffix ] [ --search-filter ] [ --replace-filter ]"
