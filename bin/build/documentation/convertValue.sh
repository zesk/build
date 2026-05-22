#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"value - String. A value."$'\n'"from - String. When value matches \`from\`, instead print \`to\`"$'\n'"to - String. The value to print when \`from\` matches \`value\`"$'\n'"... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="map a value from one value to another given from-to pairs"$'\n'""$'\n'"Prints the mapped value to stdout"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/_sugar.sh"
fn="convertValue"
fnMarker="convertvalue"
foundNames=([0]="argument")
line="161"
rawComment="map a value from one value to another given from-to pairs"$'\n'"Prints the mapped value to stdout"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - String. A value."$'\n'"Argument: from - String. When value matches \`from\`, instead print \`to\`"$'\n'"Argument: to - String. The value to print when \`from\` matches \`value\`"$'\n'"Argument: ... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="859744e8330da27fd03e1da6874909739d06ce70"
sourceLine="161"
summary="map a value from one value to another given from-to"
summaryComputed="true"
usage="convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]"
