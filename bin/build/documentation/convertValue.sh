#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"value - String. A value."$'\n'"from - String. When value matches \`from\`, instead print \`to\`"$'\n'"to - String. The value to print when \`from\` matches \`value\`"$'\n'"... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
base="_sugar.sh"
description="map a value from one value to another given from-to pairs"$'\n'""$'\n'"Prints the mapped value to stdout"$'\n'""$'\n'""
file="bin/build/tools/_sugar.sh"
fn="convertValue"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/_sugar.sh"
sourceModified="1768695727"
summary="map a value from one value to another given from-to"
usage="convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]"
