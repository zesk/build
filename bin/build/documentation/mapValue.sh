#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"--handler handler - Function. Optional.Use this error handler instead of the default error handler."$'\n'"mapFile - File. Required. a file containing bash environment definitions"$'\n'"value - String. Optional. One or more values to map using said environment file"$'\n'"--prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"--suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"--search-filter - Zero or more. Callable. Filter for search tokens. (e.g. \`lowercase\`)"$'\n'"--replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. \`trimSpace\`)"$'\n'""
base="map.sh"
description="Maps a string using an environment file"$'\n'""$'\n'""
file="bin/build/tools/map.sh"
fn="mapValue"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/map.sh"
sourceModified="1768695708"
summary="Maps a string using an environment file"
usage="mapValue [ --help ] [ --handler handler ] mapFile [ value ] [ --prefix ] [ --suffix ] [ --search-filter ] [ --replace-filter ]"
