#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="environmentVariableName - String. Optional. Map this value only. If not specified, all environment variables are mapped."$'\n'"--prefix - String. Optional. Prefix character for tokens, defaults to \`{\`."$'\n'"--suffix - String. Optional. Suffix character for tokens, defaults to \`}\`."$'\n'"--search-filter - Zero or more. Callable. Filter for search tokens. (e.g. \`lowercase\`)"$'\n'"--replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. \`trimSpace\`)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="map.sh"
description="Map tokens in the input stream based on environment values with the same names."$'\n'"Converts tokens in the form \`{ENVIRONMENT_VARIABLE}\` to the associated value."$'\n'"Undefined values are not converted."$'\n'"This one does it like \`mapValue\`"$'\n'"Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination."$'\n'""
example="    printf %s \"{NAME}, {PLACE}.\\n\" | NAME=Hello PLACE=world mapEnvironment NAME PLACE"$'\n'""
file="bin/build/tools/map.sh"
fn="mapEnvironment"
foundNames=""
requires="environmentVariables cat throwEnvironment catchEnvironment"$'\n'"throwArgument decorate validate"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="mapValue"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceModified="1769063211"
summary="Convert tokens in files to environment variable values"$'\n'""
usage="mapEnvironment [ environmentVariableName ] [ --prefix ] [ --suffix ] [ --search-filter ] [ --replace-filter ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmapEnvironment[0m [94m[ environmentVariableName ][0m [94m[ --prefix ][0m [94m[ --suffix ][0m [94m[ --search-filter ][0m [94m[ --replace-filter ][0m [94m[ --help ][0m

    [94menvironmentVariableName  [1;97mString. Optional. Map this value only. If not specified, all environment variables are mapped.[0m
    [94m--prefix                 [1;97mString. Optional. Prefix character for tokens, defaults to [38;2;0;255;0;48;2;0;0;0m{[0m.[0m
    [94m--suffix                 [1;97mString. Optional. Suffix character for tokens, defaults to [38;2;0;255;0;48;2;0;0;0m}[0m.[0m
    [94m--search-filter          [1;97mZero or more. Callable. Filter for search tokens. (e.g. [38;2;0;255;0;48;2;0;0;0mlowercase[0m)[0m
    [94m--replace-filter         [1;97mZero or more. Callable. Filter for replacement strings. (e.g. [38;2;0;255;0;48;2;0;0;0mtrimSpace[0m)[0m
    [94m--help                   [1;97mFlag. Optional. Display this help.[0m

Map tokens in the input stream based on environment values with the same names.
Converts tokens in the form [38;2;0;255;0;48;2;0;0;0m{ENVIRONMENT_VARIABLE}[0m to the associated value.
Undefined values are not converted.
This one does it like [38;2;0;255;0;48;2;0;0;0mmapValue[0m
Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
'
# shellcheck disable=SC2016
helpPlain='Usage: mapEnvironment [ environmentVariableName ] [ --prefix ] [ --suffix ] [ --search-filter ] [ --replace-filter ] [ --help ]

    environmentVariableName  String. Optional. Map this value only. If not specified, all environment variables are mapped.
    --prefix                 String. Optional. Prefix character for tokens, defaults to {.
    --suffix                 String. Optional. Suffix character for tokens, defaults to }.
    --search-filter          Zero or more. Callable. Filter for search tokens. (e.g. lowercase)
    --replace-filter         Zero or more. Callable. Filter for replacement strings. (e.g. trimSpace)
    --help                   Flag. Optional. Display this help.

Map tokens in the input stream based on environment values with the same names.
Converts tokens in the form {ENVIRONMENT_VARIABLE} to the associated value.
Undefined values are not converted.
This one does it like mapValue
Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
'
