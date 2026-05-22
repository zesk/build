#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-21
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"mapFile - File. Required. a file containing bash environment definitions"$'\n'"value - String. Optional. One or more values to map using said environment file"$'\n'"--prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"--suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"--search-filter - Zero or more. Callable. Filter for search tokens. (e.g. \`stringLowercase\`)"$'\n'"--replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. \`textTrim\`)"$'\n'""
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Maps a string using an environment file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/map.sh"
fn="mapValue"
fnMarker="mapvalue"
foundNames=([0]="argument")
line="155"
rawComment="Maps a string using an environment file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: mapFile - File. Required. a file containing bash environment definitions"$'\n'"Argument: value - String. Optional. One or more values to map using said environment file"$'\n'"Argument: --prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"Argument: --suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"Argument: --search-filter - Zero or more. Callable. Filter for search tokens. (e.g. \`stringLowercase\`)"$'\n'"Argument: --replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. \`textTrim\`)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="28c85a1a2f0604d47009077a23130a3172acf6bf"
sourceLine="155"
summary="Maps a string using an environment file"
summaryComputed="true"
usage="mapValue [ --help ] [ --handler handler ] mapFile [ value ] [ --prefix ] [ --suffix ] [ --search-filter ] [ --replace-filter ]"
