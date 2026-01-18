#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="environmentVariableName - String. Optional. Map this value only. If not specified, all environment variables are mapped."$'\n'"--prefix - String. Optional. Prefix character for tokens, defaults to \`{\`."$'\n'"--suffix - String. Optional. Suffix character for tokens, defaults to \`}\`."$'\n'"--search-filter - Zero or more. Callable. Filter for search tokens. (e.g. \`lowercase\`)"$'\n'"--replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. \`trimSpace\`)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="map.sh"
description="Map tokens in the input stream based on environment values with the same names."$'\n'"Converts tokens in the form \`{ENVIRONMENT_VARIABLE}\` to the associated value."$'\n'"Undefined values are not converted."$'\n'"This one does it like \`mapValue\`"$'\n'"Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination."$'\n'""
example="    printf %s \"{NAME}, {PLACE}.\\n\" | NAME=Hello PLACE=world mapEnvironment NAME PLACE"$'\n'""
file="bin/build/tools/map.sh"
fn="mapEnvironment"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="example" [4]="requires")
requires="environmentVariables cat throwEnvironment catchEnvironment"$'\n'"throwArgument decorate validate"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="mapValue"$'\n'""
source="bin/build/tools/map.sh"
sourceModified="1768756695"
summary="Convert tokens in files to environment variable values"$'\n'""
usage="mapEnvironment [ environmentVariableName ] [ --prefix ] [ --suffix ] [ --search-filter ] [ --replace-filter ] [ --help ]"
