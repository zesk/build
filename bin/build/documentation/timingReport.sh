#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/timing.sh"
argument="--color color - Make text this color (default is \`green\`)"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"start - Unix timestamp milliseconds. See \`timingStart\`."$'\n'"message - Any additional arguments are output before the elapsed value computed"$'\n'""
base="timing.sh"
description="Outputs the timing optionally prefixed by a message."$'\n'""$'\n'"Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message."$'\n'"Return Code: 0 - Exits with exit code zero"$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingReport \"\$init\" \"Deploy completed in\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingReport"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="timingStart"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceModified="1768782153"
summary="Output the time elapsed"$'\n'""
usage="timingReport [ --color color ] [ --help ] [ --handler handler ] [ start ] [ message ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtimingReport[0m [94m[ --color color ][0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ start ][0m [94m[ message ][0m

    [94m--color color      [1;97mMake text this color (default is [38;2;0;255;0;48;2;0;0;0mgreen[0m)[0m
    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94mstart              [1;97mUnix timestamp milliseconds. See [38;2;0;255;0;48;2;0;0;0mtimingStart[0m.[0m
    [94mmessage            [1;97mAny additional arguments are output before the elapsed value computed[0m

Outputs the timing optionally prefixed by a message.

Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.
Return Code: 0 - Exits with exit code zero

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    init=$(timingStart)
    ...
    timingReport "$init" "Deploy completed in"
'
# shellcheck disable=SC2016
helpPlain='Usage: timingReport [ --color color ] [ --help ] [ --handler handler ] [ start ] [ message ]

    --color color      Make text this color (default is green)
    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    start              Unix timestamp milliseconds. See timingStart.
    message            Any additional arguments are output before the elapsed value computed

Outputs the timing optionally prefixed by a message.

Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.
Return Code: 0 - Exits with exit code zero

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    init=$(timingStart)
    ...
    timingReport "$init" "Deploy completed in"
'
