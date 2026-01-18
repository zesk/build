#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/utilities.sh"
argument="count - Integer. Optional. Sets the value for any following named variables to this value."$'\n'"variable - String. Optional. Variable to change or increment."$'\n'"--reset - Flag. Optional. Reset all counters to zero."$'\n'""
base="utilities.sh"
depends="buildCacheDirectory"$'\n'""
description="Set or increment a process-wide incrementor. If no numeric value is supplied the default is to increment the current value and output it."$'\n'"New values are set to 0 by default so will output \`1\` upon first handler."$'\n'"If no variable name is supplied it uses the default variable name \`default\`."$'\n'""$'\n'"Variable names can contain alphanumeric characters, underscore, or dash."$'\n'""$'\n'"Sets \`default\` incrementor to 1 and outputs \`1\`"$'\n'""$'\n'"    {fn} 1"$'\n'""$'\n'"Increments the \`kitty\` counter and outputs \`1\` on first call and \`n + 1\` for each subsequent call."$'\n'""$'\n'"    {fn} kitty"$'\n'""$'\n'"Sets \`kitty\` incrementor to 2 and outputs \`2\`"$'\n'""$'\n'"    {fn} 2 kitty"$'\n'""$'\n'"shellcheck disable=SC2120"$'\n'""
file="bin/build/tools/utilities.sh"
fn="incrementor"
foundNames=([0]="argument" [1]="depends" [2]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildCacheDirectory"$'\n'""
source="bin/build/tools/utilities.sh"
sourceModified="1768756695"
summary="Set or increment a process-wide incrementor. If no numeric value"
usage="incrementor [ count ] [ variable ] [ --reset ]"
