#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="count - Integer. Optional. Sets the value for any following named variables to this value."$'\n'"variable - String. Optional. Variable to change or increment."$'\n'"--path cacheDirectory - Directory. Optional. Use this directory path as the state directory."$'\n'"--reset - Flag. Optional. Reset all counters to zero."$'\n'"--separator - String. Optional. When dumping all variables use this as the separator between name and value. (Default is space: \`\"  \"\`)"$'\n'"--line - String. Optional. When dumping all variables use this as the separator between values. (Default is newline: \`\$'\\n'\`)"$'\n'""
base="utilities.sh"
depends="buildCacheDirectory"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set or increment a incrementor state based on a state directory. If no numeric value is supplied the default is to increment the current value and output it."$'\n'"New values are set to 0 by default so will output \`1\` upon first handler."$'\n'"If no variable name is supplied it uses the default variable name \`default\`."$'\n'""$'\n'"Variable names can contain alphanumeric characters, underscore, or dash."$'\n'""$'\n'"The special count \`?\` is used to query variables directly by name without modifying them."$'\n'"Passing \`?\` on the command line without any name arguments will output all incrementors active using the \`--separator\` and \`--line\` markers."$'\n'""$'\n'"Sets \`default\` incrementor to 1 and outputs \`1\`"$'\n'""$'\n'"    {fn} 1"$'\n'""$'\n'"Increments the \`kitty\` counter and outputs \`1\` on first call and \`n + 1\` for each subsequent call."$'\n'""$'\n'"    {fn} kitty"$'\n'""$'\n'"Sets \`kitty\` incrementor to 2 and outputs \`2\`"$'\n'""$'\n'"    {fn} 2 kitty"$'\n'""$'\n'"Dumps the current incrementors:"$'\n'""$'\n'"    {fn} ?"$'\n'"    default 1"$'\n'"    kitty 2"$'\n'""$'\n'"The default cache \`--path\` is placed within the \`buildCacheDirectory\`."$'\n'""$'\n'""
descriptionLineCount="29"
file="bin/build/tools/utilities.sh"
fn="incrementor"
fnMarker="incrementor"
foundNames=([0]="argument" [1]="depends" [2]="see")
line="52"
rawComment="Argument: count - Integer. Optional. Sets the value for any following named variables to this value."$'\n'"Argument: variable - String. Optional. Variable to change or increment."$'\n'"Argument: --path cacheDirectory - Directory. Optional. Use this directory path as the state directory."$'\n'"Argument: --reset - Flag. Optional. Reset all counters to zero."$'\n'"Argument: --separator - String. Optional. When dumping all variables use this as the separator between name and value. (Default is space: \`\"  \"\`)"$'\n'"Argument: --line - String. Optional. When dumping all variables use this as the separator between values. (Default is newline: \`\$'\\n'\`)"$'\n'"Set or increment a incrementor state based on a state directory. If no numeric value is supplied the default is to increment the current value and output it."$'\n'"New values are set to 0 by default so will output \`1\` upon first handler."$'\n'"If no variable name is supplied it uses the default variable name \`default\`."$'\n'"Variable names can contain alphanumeric characters, underscore, or dash."$'\n'"The special count \`?\` is used to query variables directly by name without modifying them."$'\n'"Passing \`?\` on the command line without any name arguments will output all incrementors active using the \`--separator\` and \`--line\` markers."$'\n'"Sets \`default\` incrementor to 1 and outputs \`1\`"$'\n'"    {fn} 1"$'\n'"Increments the \`kitty\` counter and outputs \`1\` on first call and \`n + 1\` for each subsequent call."$'\n'"    {fn} kitty"$'\n'"Sets \`kitty\` incrementor to 2 and outputs \`2\`"$'\n'"    {fn} 2 kitty"$'\n'"Dumps the current incrementors:"$'\n'"    {fn} ?"$'\n'"    default 1"$'\n'"    kitty 2"$'\n'"The default cache \`--path\` is placed within the \`buildCacheDirectory\`."$'\n'"Depends: buildCacheDirectory"$'\n'"See: buildCacheDirectory"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildCacheDirectory"$'\n'""
sourceFile="bin/build/tools/utilities.sh"
sourceHash="94563d0a08741ddbc0e4c700e450e33a3cb9e86f"
sourceLine="52"
summary="Set or increment a incrementor state based on a state"
summaryComputed="true"
usage="incrementor [ count ] [ variable ] [ --path cacheDirectory ] [ --reset ] [ --separator ] [ --line ]"
