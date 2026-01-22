#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"--help - Flag. Optional. Display this help."$'\n'"text - EmptyString. Required. text to convert to uppercase"$'\n'""
base="text.sh"
description="Convert text to uppercase"$'\n'""$'\n'""
file="bin/build/tools/text.sh"
fn="uppercase"
foundNames=""
requires="tr"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdout="\`String\`. The uppercase version of the \`text\`."$'\n'""
summary="Convert text to uppercase"
usage="uppercase [ -- ] [ --help ] text"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255muppercase[0m [94m[ -- ][0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m

    [94m--      [1;97mFlag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [31mtext    [1;97mEmptyString. Required. text to convert to uppercase[0m

Convert text to uppercase

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mString[0m. The uppercase version of the [38;2;0;255;0;48;2;0;0;0mtext[0m.
'
# shellcheck disable=SC2016
helpPlain='Usage: uppercase [ -- ] [ --help ] text

    --      Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
    --help  Flag. Optional. Display this help.
    text    EmptyString. Required. text to convert to uppercase

Convert text to uppercase

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
String. The uppercase version of the text.
'
