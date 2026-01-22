#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/utilities.sh"
argument="count - Integer. Optional. Sets the value for any following named variables to this value."$'\n'"variable - String. Optional. Variable to change or increment."$'\n'"--reset - Flag. Optional. Reset all counters to zero."$'\n'""
base="utilities.sh"
depends="buildCacheDirectory"$'\n'""
description="Set or increment a process-wide incrementor. If no numeric value is supplied the default is to increment the current value and output it."$'\n'"New values are set to 0 by default so will output \`1\` upon first handler."$'\n'"If no variable name is supplied it uses the default variable name \`default\`."$'\n'""$'\n'"Variable names can contain alphanumeric characters, underscore, or dash."$'\n'""$'\n'"Sets \`default\` incrementor to 1 and outputs \`1\`"$'\n'""$'\n'"    {fn} 1"$'\n'""$'\n'"Increments the \`kitty\` counter and outputs \`1\` on first call and \`n + 1\` for each subsequent call."$'\n'""$'\n'"    {fn} kitty"$'\n'""$'\n'"Sets \`kitty\` incrementor to 2 and outputs \`2\`"$'\n'""$'\n'"    {fn} 2 kitty"$'\n'""$'\n'"shellcheck disable=SC2120"$'\n'""
file="bin/build/tools/utilities.sh"
fn="incrementor"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildCacheDirectory"$'\n'""
sourceFile="bin/build/tools/utilities.sh"
sourceModified="1768756695"
summary="Set or increment a process-wide incrementor. If no numeric value"
usage="incrementor [ count ] [ variable ] [ --reset ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mincrementor[0m [94m[ count ][0m [94m[ variable ][0m [94m[ --reset ][0m

    [94mcount     [1;97mInteger. Optional. Sets the value for any following named variables to this value.[0m
    [94mvariable  [1;97mString. Optional. Variable to change or increment.[0m
    [94m--reset   [1;97mFlag. Optional. Reset all counters to zero.[0m

Set or increment a process-wide incrementor. If no numeric value is supplied the default is to increment the current value and output it.
New values are set to 0 by default so will output [38;2;0;255;0;48;2;0;0;0m1[0m upon first handler.
If no variable name is supplied it uses the default variable name [38;2;0;255;0;48;2;0;0;0mdefault[0m.

Variable names can contain alphanumeric characters, underscore, or dash.

Sets [38;2;0;255;0;48;2;0;0;0mdefault[0m incrementor to 1 and outputs [38;2;0;255;0;48;2;0;0;0m1[0m

    incrementor 1

Increments the [38;2;0;255;0;48;2;0;0;0mkitty[0m counter and outputs [38;2;0;255;0;48;2;0;0;0m1[0m on first call and [38;2;0;255;0;48;2;0;0;0mn + 1[0m for each subsequent call.

    incrementor kitty

Sets [38;2;0;255;0;48;2;0;0;0mkitty[0m incrementor to 2 and outputs [38;2;0;255;0;48;2;0;0;0m2[0m

    incrementor 2 kitty

shellcheck disable=SC2120

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: incrementor [ count ] [ variable ] [ --reset ]

    count     Integer. Optional. Sets the value for any following named variables to this value.
    variable  String. Optional. Variable to change or increment.
    --reset   Flag. Optional. Reset all counters to zero.

Set or increment a process-wide incrementor. If no numeric value is supplied the default is to increment the current value and output it.
New values are set to 0 by default so will output 1 upon first handler.
If no variable name is supplied it uses the default variable name default.

Variable names can contain alphanumeric characters, underscore, or dash.

Sets default incrementor to 1 and outputs 1

    incrementor 1

Increments the kitty counter and outputs 1 on first call and n + 1 for each subsequent call.

    incrementor kitty

Sets kitty incrementor to 2 and outputs 2

    incrementor 2 kitty

shellcheck disable=SC2120

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
