#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt.sh"
argument="text - String. Required. List of color names in a colon separated list."$'\n'""
base="prompt.sh"
description="Given a list of color names, generate the color codes in a colon separated list"$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPromptColorsFormat"
foundNames=""
requires="decorations read inArray decorate listJoin"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceModified="1769063211"
stdout="Outputs color *codes* separated by colons."$'\n'""
summary="Given a list of color names, generate the color codes"
usage="bashPromptColorsFormat text"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashPromptColorsFormat[0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m

    [31mtext  [1;97mString. Required. List of color names in a colon separated list.[0m

Given a list of color names, generate the color codes in a colon separated list

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Outputs color [36mcodes[0m separated by colons.
'
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptColorsFormat text

    text  String. Required. List of color names in a colon separated list.

Given a list of color names, generate the color codes in a colon separated list

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
Outputs color codes separated by colons.
'
