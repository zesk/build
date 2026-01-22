#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--last - Flag. Optional. Last message to be output, so output a newline as well at the end."$'\n'"--first - Flag. Optional. First message to be output, only clears line if available."$'\n'"--inline - Flag. Optional. Inline message displays with newline when animation is NOT available."$'\n'"command - Required. Commands which output a message."$'\n'""
base="colors.sh"
description="Output a status message"$'\n'""$'\n'"This is intended for messages on a line which are then overwritten using clearLine"$'\n'""$'\n'"Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it."$'\n'""$'\n'"When \`hasConsoleAnimation\` is true:"$'\n'""$'\n'"\`--first\` - clears the line and outputs the message starting at the left column, no newline"$'\n'"\`--last\` - clears the line and outputs the message starting at the left column, with a newline"$'\n'"\`--inline\` - Outputs the message at the cursor without a newline"$'\n'""$'\n'"When \`hasConsoleAnimation\` is false:"$'\n'""$'\n'"\`--first\` - outputs the message starting at the cursor, no newline"$'\n'"\`--last\` - outputs the message starting at the cursor, with a newline"$'\n'"\`--inline\` - Outputs the message at the cursor with a newline"$'\n'""$'\n'""
environment="Intended to be run on an interactive console. Should support \$(tput cols)."$'\n'""
example="    statusMessage decorate info \"Loading ...\""$'\n'"    bin/load.sh >>\"\$loadLogFile\""$'\n'"    clearLine"$'\n'""
file="bin/build/tools/colors.sh"
fn="statusMessage"
requires="throwArgument hasConsoleAnimation catchEnvironment decorate validate clearLine"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
summary="Output a status message and display correctly on consoles with animation and in log files"$'\n'""
usage="statusMessage [ --last ] [ --first ] [ --inline ] command"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mstatusMessage[0m [94m[ --last ][0m [94m[ --first ][0m [94m[ --inline ][0m [38;2;255;255;0m[35;48;2;0;0;0mcommand[0m[0m

    [94m--last    [1;97mFlag. Optional. Last message to be output, so output a newline as well at the end.[0m
    [94m--first   [1;97mFlag. Optional. First message to be output, only clears line if available.[0m
    [94m--inline  [1;97mFlag. Optional. Inline message displays with newline when animation is NOT available.[0m
    [31mcommand   [1;97mRequired. Commands which output a message.[0m

Output a status message

This is intended for messages on a line which are then overwritten using clearLine

Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it.

When [38;2;0;255;0;48;2;0;0;0mhasConsoleAnimation[0m is true:

[38;2;0;255;0;48;2;0;0;0m--first[0m - clears the line and outputs the message starting at the left column, no newline
[38;2;0;255;0;48;2;0;0;0m--last[0m - clears the line and outputs the message starting at the left column, with a newline
[38;2;0;255;0;48;2;0;0;0m--inline[0m - Outputs the message at the cursor without a newline

When [38;2;0;255;0;48;2;0;0;0mhasConsoleAnimation[0m is false:

[38;2;0;255;0;48;2;0;0;0m--first[0m - outputs the message starting at the cursor, no newline
[38;2;0;255;0;48;2;0;0;0m--last[0m - outputs the message starting at the cursor, with a newline
[38;2;0;255;0;48;2;0;0;0m--inline[0m - Outputs the message at the cursor with a newline

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Intended to be run on an interactive console. Should support $(tput cols).
- 

Example:
    statusMessage decorate info "Loading ..."
    bin/load.sh >>"$loadLogFile"
    clearLine
'
# shellcheck disable=SC2016
helpPlain='Usage: statusMessage [ --last ] [ --first ] [ --inline ] command

    --last    Flag. Optional. Last message to be output, so output a newline as well at the end.
    --first   Flag. Optional. First message to be output, only clears line if available.
    --inline  Flag. Optional. Inline message displays with newline when animation is NOT available.
    command   Required. Commands which output a message.

Output a status message

This is intended for messages on a line which are then overwritten using clearLine

Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it.

When hasConsoleAnimation is true:

--first - clears the line and outputs the message starting at the left column, no newline
--last - clears the line and outputs the message starting at the left column, with a newline
--inline - Outputs the message at the cursor without a newline

When hasConsoleAnimation is false:

--first - outputs the message starting at the cursor, no newline
--last - outputs the message starting at the cursor, with a newline
--inline - Outputs the message at the cursor with a newline

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Intended to be run on an interactive console. Should support $(tput cols).
- 

Example:
    statusMessage decorate info "Loading ..."
    bin/load.sh >>"$loadLogFile"
    clearLine
'
