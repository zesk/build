#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Optional. Identical arguments to \`read\` (but includes \`-r\`)"$'\n'""
base="prompt.sh"
description="Prompt the user properly honoring any attached console."$'\n'""$'\n'"Arguments are the same as \`read\`, except:"$'\n'""$'\n'"\`-r\` is implied and does not need to be specified"$'\n'""$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashUserInput"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="read"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceModified="1769063211"
summary="Prompt the user properly honoring any attached console."
usage="bashUserInput [ --help ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashUserInput[0m [94m[ --help ][0m [94m[ ... ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94m...     [1;97mArguments. Optional. Identical arguments to [38;2;0;255;0;48;2;0;0;0mread[0m (but includes [38;2;0;255;0;48;2;0;0;0m-r[0m)[0m

Prompt the user properly honoring any attached console.

Arguments are the same as [38;2;0;255;0;48;2;0;0;0mread[0m, except:

[38;2;0;255;0;48;2;0;0;0m-r[0m is implied and does not need to be specified

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashUserInput [ --help ] [ ... ]

    --help  Flag. Optional. Display this help.
    ...     Arguments. Optional. Identical arguments to read (but includes -r)

Prompt the user properly honoring any attached console.

Arguments are the same as read, except:

-r is implied and does not need to be specified

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
