#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"mapFile - File. Required. a file containing bash environment definitions"$'\n'"value - String. Optional. One or more values to map using said environment file"$'\n'"--prefix - String. Optional. Token prefix defaults to \`{\`."$'\n'"--suffix - String. Optional. Token suffix defaults to \`}\`."$'\n'"--search-filter - Zero or more. Callable. Filter for search tokens. (e.g. \`lowercase\`)"$'\n'"--replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. \`trimSpace\`)"$'\n'""
base="map.sh"
description="Maps a string using an environment file"$'\n'""$'\n'""
file="bin/build/tools/map.sh"
fn="mapValue"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceModified="1768756695"
summary="Maps a string using an environment file"
usage="mapValue [ --help ] [ --handler handler ] mapFile [ value ] [ --prefix ] [ --suffix ] [ --search-filter ] [ --replace-filter ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmapValue[0m [94m[ --help ][0m [94m[ --handler handler ][0m [38;2;255;255;0m[35;48;2;0;0;0mmapFile[0m[0m [94m[ value ][0m [94m[ --prefix ][0m [94m[ --suffix ][0m [94m[ --search-filter ][0m [94m[ --replace-filter ][0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [31mmapFile            [1;97mFile. Required. a file containing bash environment definitions[0m
    [94mvalue              [1;97mString. Optional. One or more values to map using said environment file[0m
    [94m--prefix           [1;97mString. Optional. Token prefix defaults to [38;2;0;255;0;48;2;0;0;0m{[0m.[0m
    [94m--suffix           [1;97mString. Optional. Token suffix defaults to [38;2;0;255;0;48;2;0;0;0m}[0m.[0m
    [94m--search-filter    [1;97mZero or more. Callable. Filter for search tokens. (e.g. [38;2;0;255;0;48;2;0;0;0mlowercase[0m)[0m
    [94m--replace-filter   [1;97mZero or more. Callable. Filter for replacement strings. (e.g. [38;2;0;255;0;48;2;0;0;0mtrimSpace[0m)[0m

Maps a string using an environment file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: mapValue [ --help ] [ --handler handler ] mapFile [ value ] [ --prefix ] [ --suffix ] [ --search-filter ] [ --replace-filter ]

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    mapFile            File. Required. a file containing bash environment definitions
    value              String. Optional. One or more values to map using said environment file
    --prefix           String. Optional. Token prefix defaults to {.
    --suffix           String. Optional. Token suffix defaults to }.
    --search-filter    Zero or more. Callable. Filter for search tokens. (e.g. lowercase)
    --replace-filter   Zero or more. Callable. Filter for replacement strings. (e.g. trimSpace)

Maps a string using an environment file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
