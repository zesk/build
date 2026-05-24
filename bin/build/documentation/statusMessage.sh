#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--last - Flag. Optional. Last message to be output, so output a newline as well at the end.\n--first - Flag. Optional. First message to be output, only clears line if available.\n--inline - Flag. Optional. Inline message displays with newline when animation is NOT available.\ncommand - Required. Commands which output a message.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output a status message\n\nThis is intended for messages on a line which are then overwritten using consoleLineFill\n\nClears the line and outputs a message using a command. Meant to show status but not use up an output line for it.\n\nWhen $(consoleHasAnimation) is true:\n\n$(--first) - clears the line and outputs the message starting at the left column, no newline\n$(--last) - clears the line and outputs the message starting at the left column, with a newline\n$(--inline) - Outputs the message at the cursor without a newline\n\nWhen $(consoleHasAnimation) is false:\n\n$(--first) - outputs the message starting at the cursor, no newline\n$(--last) - outputs the message starting at the cursor, with a newline\n$(--inline) - Outputs the message at the cursor with a newline\n\n'
descriptionLineCount="18"
environment=$'Intended to be run on an interactive console. Should support $(tput cols).\n'
example=$'    statusMessage decorate info "Loading ..."\n    bin/load.sh >>"$loadLogFile"\n    consoleLineFill\n'
file="bin/build/tools/colors.sh"
fn="statusMessage"
fnMarker="statusmessage"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="example" [4]="requires")
line="316"
rawComment=$'Output a status message\nThis is intended for messages on a line which are then overwritten using consoleLineFill\nSummary: Output a status message and display correctly on consoles with animation and in log files\nClears the line and outputs a message using a command. Meant to show status but not use up an output line for it.\nArgument: --last - Flag. Optional. Last message to be output, so output a newline as well at the end.\nArgument: --first - Flag. Optional. First message to be output, only clears line if available.\nArgument: --inline - Flag. Optional. Inline message displays with newline when animation is NOT available.\nArgument: command - Required. Commands which output a message.\nWhen $(consoleHasAnimation) is true:\n$(--first) - clears the line and outputs the message starting at the left column, no newline\n$(--last) - clears the line and outputs the message starting at the left column, with a newline\n$(--inline) - Outputs the message at the cursor without a newline\nWhen $(consoleHasAnimation) is false:\n$(--first) - outputs the message starting at the cursor, no newline\n$(--last) - outputs the message starting at the cursor, with a newline\n$(--inline) - Outputs the message at the cursor with a newline\nEnvironment: Intended to be run on an interactive console. Should support $(tput cols).\nExample:     statusMessage decorate info "Loading ..."\nExample:     bin/load.sh >>"$loadLogFile"\nExample:     consoleLineFill\nRequires: throwArgument consoleHasAnimation catchEnvironment decorate validate consoleLineFill\n\n'
requires=$'throwArgument consoleHasAnimation catchEnvironment decorate validate consoleLineFill\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="316"
summary="Output a status message and display correctly on consoles with animation and in log files"
summaryComputed=""
usage="statusMessage [ --last ] [ --first ] [ --inline ] command"
