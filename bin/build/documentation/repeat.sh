#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="\`count\` - Required, integer count of times to repeat"$'\n'"\`string\` - A sequence of characters to repeat"$'\n'"... - Additional arguments are output using shell expansion of \`\$*\`"$'\n'""
base="decoration.sh"
description="Repeat a string"$'\n'""
example="    repeat 80 ="$'\n'"    decorate info Hello world"$'\n'"    repeat 80 -"$'\n'""
file="bin/build/tools/decoration.sh"
fn="repeat"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decoration.sh"
sourceModified="1769063211"
summary="Repeat a string"
usage="repeat [ \`count\` ] [ \`string\` ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mrepeat[0m [94m[ `count` ][0m [94m[ `string` ][0m [94m[ ... ][0m

    [31m[38;2;0;255;0;48;2;0;0;0mcount[0m   [1;97mRequired, integer count of times to repeat[0m
    [94m[38;2;0;255;0;48;2;0;0;0mstring[0m  [1;97mA sequence of characters to repeat[0m
    [94m...       [1;97mAdditional arguments are output using shell expansion of [38;2;0;255;0;48;2;0;0;0m$[36m[0m[0m[0m

Repeat a string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    repeat 80 =
    decorate info Hello world
    repeat 80 -
'
# shellcheck disable=SC2016
helpPlain='Usage: repeat [ `count` ] [ `string` ] [ ... ]

    count   Required, integer count of times to repeat
    string  A sequence of characters to repeat
    ...       Additional arguments are output using shell expansion of $

Repeat a string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    repeat 80 =
    decorate info Hello world
    repeat 80 -
'
