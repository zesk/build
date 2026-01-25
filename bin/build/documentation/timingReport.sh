#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/timing.sh"
argument="--color color - Make text this color (default is \`green\`)"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"start - Unix timestamp milliseconds. See \`timingStart\`."$'\n'"message - Any additional arguments are output before the elapsed value computed"$'\n'""
base="timing.sh"
description="Outputs the timing optionally prefixed by a message."$'\n'"Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message."$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingReport \"\$init\" \"Deploy completed in\""$'\n'""
exitCode="0"
file="bin/build/tools/timing.sh"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="see" [4]="example")
init=""
rawComment="Outputs the timing optionally prefixed by a message."$'\n'"Summary: Output the time elapsed"$'\n'"Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message."$'\n'"Argument: --color color - Make text this color (default is \`green\`)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: start - Unix timestamp milliseconds. See \`timingStart\`."$'\n'"Argument: message - Any additional arguments are output before the elapsed value computed"$'\n'"Return Code: 0 - Exits with exit code zero"$'\n'"See: timingStart"$'\n'"Example:     init=\$(timingStart)"$'\n'"Example:     ..."$'\n'"Example:     timingReport \"\$init\" \"Deploy completed in\""$'\n'""$'\n'""
return_code="0 - Exits with exit code zero"$'\n'""
see="timingStart"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceModified="1769063211"
summary="Output the time elapsed"$'\n'""
usage="timingReport [ --color color ] [ --help ] [ --handler handler ] [ start ] [ message ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mtimingReport'$'\e''[0m '$'\e''[[blue]m[ --color color ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ --handler handler ]'$'\e''[0m '$'\e''[[blue]m[ start ]'$'\e''[0m '$'\e''[[blue]m[ message ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--color color      '$'\e''[[value]mMake text this color (default is '$'\e''[[code]mgreen'$'\e''[[reset]m)'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help             '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--handler handler  '$'\e''[[value]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mstart              '$'\e''[[value]mUnix timestamp milliseconds. See '$'\e''[[code]mtimingStart'$'\e''[[reset]m.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mmessage            '$'\e''[[value]mAny additional arguments are output before the elapsed value computed'$'\e''[[reset]m'$'\n'''$'\n''Outputs the timing optionally prefixed by a message.'$'\n''Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Exits with exit code zero'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingReport "$init" "Deploy completed in"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timingReport [ --color color ] [ --help ] [ --handler handler ] [ start ] [ message ]'$'\n'''$'\n''    --color color      Make text this color (default is green)'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    start              Unix timestamp milliseconds. See timingStart.'$'\n''    message            Any additional arguments are output before the elapsed value computed'$'\n'''$'\n''Outputs the timing optionally prefixed by a message.'$'\n''Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Exits with exit code zero'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingReport "$init" "Deploy completed in"'$'\n'''
