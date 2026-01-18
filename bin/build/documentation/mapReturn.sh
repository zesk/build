#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"value - Integer. A return value."$'\n'"from - Integer. When value matches \`from\`, instead return \`to\`"$'\n'"to - Integer. The value to return when \`from\` matches \`value\`"$'\n'"... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
base="sugar.sh"
description="map a return value from one value to another"$'\n'""$'\n'""
file="bin/build/tools/sugar.sh"
fn="mapReturn"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/sugar.sh"
sourceModified="1768695708"
summary="map a return value from one value to another"
usage="mapReturn [ --help ] [ value ] [ from ] [ to ] [ ... ]"
