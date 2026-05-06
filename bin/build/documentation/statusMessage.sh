#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--last - Flag. Optional. Last message to be output, so output a newline as well at the end."$'\n'"--first - Flag. Optional. First message to be output, only clears line if available."$'\n'"--inline - Flag. Optional. Inline message displays with newline when animation is NOT available."$'\n'"command - Required. Commands which output a message."$'\n'""
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output a status message"$'\n'""$'\n'"This is intended for messages on a line which are then overwritten using consoleLineFill"$'\n'""$'\n'"Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it."$'\n'""$'\n'"When \$(consoleHasAnimation) is true:"$'\n'""$'\n'"\$(--first) - clears the line and outputs the message starting at the left column, no newline"$'\n'"\$(--last) - clears the line and outputs the message starting at the left column, with a newline"$'\n'"\$(--inline) - Outputs the message at the cursor without a newline"$'\n'""$'\n'"When \$(consoleHasAnimation) is false:"$'\n'""$'\n'"\$(--first) - outputs the message starting at the cursor, no newline"$'\n'"\$(--last) - outputs the message starting at the cursor, with a newline"$'\n'"\$(--inline) - Outputs the message at the cursor with a newline"$'\n'""$'\n'""
descriptionLineCount="18"
environment="Intended to be run on an interactive console. Should support \$(tput cols)."$'\n'""
example="    statusMessage decorate info \"Loading ...\""$'\n'"    bin/load.sh >>\"\$loadLogFile\""$'\n'"    consoleLineFill"$'\n'""
file="bin/build/tools/colors.sh"
fn="statusMessage"
fnMarker="statusmessage"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="example" [4]="requires")
line="314"
rawComment="Output a status message"$'\n'"This is intended for messages on a line which are then overwritten using consoleLineFill"$'\n'"Summary: Output a status message and display correctly on consoles with animation and in log files"$'\n'"Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it."$'\n'"Argument: --last - Flag. Optional. Last message to be output, so output a newline as well at the end."$'\n'"Argument: --first - Flag. Optional. First message to be output, only clears line if available."$'\n'"Argument: --inline - Flag. Optional. Inline message displays with newline when animation is NOT available."$'\n'"Argument: command - Required. Commands which output a message."$'\n'"When \$(consoleHasAnimation) is true:"$'\n'"\$(--first) - clears the line and outputs the message starting at the left column, no newline"$'\n'"\$(--last) - clears the line and outputs the message starting at the left column, with a newline"$'\n'"\$(--inline) - Outputs the message at the cursor without a newline"$'\n'"When \$(consoleHasAnimation) is false:"$'\n'"\$(--first) - outputs the message starting at the cursor, no newline"$'\n'"\$(--last) - outputs the message starting at the cursor, with a newline"$'\n'"\$(--inline) - Outputs the message at the cursor with a newline"$'\n'"Environment: Intended to be run on an interactive console. Should support \$(tput cols)."$'\n'"Example:     statusMessage decorate info \"Loading ...\""$'\n'"Example:     bin/load.sh >>\"\$loadLogFile\""$'\n'"Example:     consoleLineFill"$'\n'"Requires: throwArgument consoleHasAnimation catchEnvironment decorate validate consoleLineFill"$'\n'""$'\n'""
requires="throwArgument consoleHasAnimation catchEnvironment decorate validate consoleLineFill"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="314"
summary="Output a status message and display correctly on consoles with animation and in log files"
summaryComputed=""
usage="statusMessage [ --last ] [ --first ] [ --inline ] command"
