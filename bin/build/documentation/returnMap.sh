#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"value - Integer. A return value."$'\n'"from - Integer. When value matches \`from\`, instead return \`to\`"$'\n'"to - Integer. The value to return when \`from\` matches \`value\`"$'\n'"... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
base="sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="map a return value from one value to another"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/sugar.sh"
fn="returnMap"
fnMarker="returnmap"
foundNames=([0]="argument")
line="88"
rawComment="map a return value from one value to another"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - Integer. A return value."$'\n'"Argument: from - Integer. When value matches \`from\`, instead return \`to\`"$'\n'"Argument: to - Integer. The value to return when \`from\` matches \`value\`"$'\n'"Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="e8338cd30cac46f1f4725c84ca79d511b7921f72"
sourceLine="88"
summary="map a return value from one value to another"
summaryComputed="true"
usage="returnMap [ --help ] [ value ] [ from ] [ to ] [ ... ]"
