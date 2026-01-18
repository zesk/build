#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--last - Flag. Optional. Last message to be output, so output a newline as well at the end."$'\n'"--first - Flag. Optional. First message to be output, only clears line if available."$'\n'"--inline - Flag. Optional. Inline message displays with newline when animation is NOT available."$'\n'"command - Required. Commands which output a message."$'\n'""
base="colors.sh"
description="Output a status message"$'\n'""$'\n'"This is intended for messages on a line which are then overwritten using clearLine"$'\n'""$'\n'"Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it."$'\n'""$'\n'"When \`hasConsoleAnimation\` is true:"$'\n'""$'\n'"\`--first\` - clears the line and outputs the message starting at the left column, no newline"$'\n'"\`--last\` - clears the line and outputs the message starting at the left column, with a newline"$'\n'"\`--inline\` - Outputs the message at the cursor without a newline"$'\n'""$'\n'"When \`hasConsoleAnimation\` is false:"$'\n'""$'\n'"\`--first\` - outputs the message starting at the cursor, no newline"$'\n'"\`--last\` - outputs the message starting at the cursor, with a newline"$'\n'"\`--inline\` - Outputs the message at the cursor with a newline"$'\n'""$'\n'""
environment="Intended to be run on an interactive console. Should support \$(tput cols)."$'\n'""
example="    statusMessage decorate info \"Loading ...\""$'\n'"    bin/load.sh >>\"\$loadLogFile\""$'\n'"    clearLine"$'\n'""
file="bin/build/tools/colors.sh"
fn="statusMessage"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="example" [4]="requires")
requires="throwArgument hasConsoleAnimation catchEnvironment decorate validate clearLine"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/colors.sh"
sourceModified="1768757397"
summary="Output a status message and display correctly on consoles with animation and in log files"$'\n'""
usage="statusMessage [ --last ] [ --first ] [ --inline ] command"
