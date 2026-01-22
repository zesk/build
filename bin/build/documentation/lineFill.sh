#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="barText - String. Required. Text to fill line with, repeated. If not specified uses \`-\`"$'\n'"displayText - String. Optional.  Text to display on the line before the fill bar."$'\n'""
base="decoration.sh"
description="Output a line and fill columns with a character"$'\n'""
file="bin/build/tools/decoration.sh"
fn="lineFill"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decoration.sh"
sourceModified="1768721469"
summary="Output a line and fill columns with a character"
usage="lineFill barText [ displayText ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mlineFill[0m [38;2;255;255;0m[35;48;2;0;0;0mbarText[0m[0m [94m[ displayText ][0m

    [31mbarText      [1;97mString. Required. Text to fill line with, repeated. If not specified uses [38;2;0;255;0;48;2;0;0;0m-[0m[0m
    [94mdisplayText  [1;97mString. Optional.  Text to display on the line before the fill bar.[0m

Output a line and fill columns with a character

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: lineFill barText [ displayText ]

    barText      String. Required. Text to fill line with, repeated. If not specified uses -
    displayText  String. Optional.  Text to display on the line before the fill bar.

Output a line and fill columns with a character

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
