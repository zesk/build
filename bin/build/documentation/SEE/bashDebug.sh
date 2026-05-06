#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
### Flow control
### Watching
### Utilities
### Flow control
### Watching
### Utilities
argument="commandToDebug ... - Callable. Required. Command to debug."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="debugger.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="\`{fn}\`: Simple debugger to walk through a program."$'\n'""$'\n'"Debugger accepts the following keystrokes:"$'\n'""$'\n'"### Flow control"$'\n'""$'\n'"- \`.\` or \` \` or Return - Repeat last flow command"$'\n'""$'\n'"- \`j\`         - Skip next command (jump over)"$'\n'"- \`s\` or \`n\`  - Step to next command (step)"$'\n'"- \`i\` or \`d\`  - Step into next command (follow)"$'\n'"- \`q\`         - Quit debugger (and continue execution)"$'\n'"- \`!\`         - Enter a command to execute"$'\n'""$'\n'"### Watching"$'\n'""$'\n'"- \`w\`         - Enter a watch expression"$'\n'"- \`u\`         - Remove a watch expression"$'\n'""$'\n'"### Utilities"$'\n'""$'\n'"\`k\`         - Display call stack"$'\n'"\`*\`         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)"$'\n'"\`h\` or \`?\`  - This help"$'\n'""$'\n'""
descriptionLineCount="25"
file="bin/build/tools/debugger.sh"
fn="bashDebug"
fnMarker="bashdebug"
foundNames=([0]="summary" [1]="argument")
line="41"
rawComment="Summary: Bash debugger"$'\n'"\`{fn}\`: Simple debugger to walk through a program."$'\n'"Argument: commandToDebug ... - Callable. Required. Command to debug."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Debugger accepts the following keystrokes:"$'\n'"### Flow control"$'\n'"- \`.\` or \` \` or Return - Repeat last flow command"$'\n'"- \`j\`         - Skip next command (jump over)"$'\n'"- \`s\` or \`n\`  - Step to next command (step)"$'\n'"- \`i\` or \`d\`  - Step into next command (follow)"$'\n'"- \`q\`         - Quit debugger (and continue execution)"$'\n'"- \`!\`         - Enter a command to execute"$'\n'"### Watching"$'\n'"- \`w\`         - Enter a watch expression"$'\n'"- \`u\`         - Remove a watch expression"$'\n'"### Utilities"$'\n'"\`k\`         - Display call stack"$'\n'"\`*\`         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)"$'\n'"\`h\` or \`?\`  - This help"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceHash="eb917fc1a453c6909bff7a48c28fcd6f23dae1ab"
sourceLine="41"
summary="Bash debugger"
summaryComputed=""
usage="bashDebug commandToDebug ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDebug'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommandToDebug ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcommandToDebug ...  '$'\e''[[(value)]mCallable. Required. Command to debug.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help              '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n'''$'\e''[[(code)]mbashDebug'$'\e''[[(reset)]m: Simple debugger to walk through a program.'$'\n'''$'\n''Debugger accepts the following keystrokes:'$'\n'''$'\n''### Flow control'$'\n'''$'\n''- '$'\e''[[(code)]m.'$'\e''[[(reset)]m or '$'\e''[[(code)]m '$'\e''[[(reset)]m or Return - Repeat last flow command'$'\n'''$'\n''- '$'\e''[[(code)]mj'$'\e''[[(reset)]m         - Skip next command (jump over)'$'\n''- '$'\e''[[(code)]ms'$'\e''[[(reset)]m or '$'\e''[[(code)]mn'$'\e''[[(reset)]m  - Step to next command (step)'$'\n''- '$'\e''[[(code)]mi'$'\e''[[(reset)]m or '$'\e''[[(code)]md'$'\e''[[(reset)]m  - Step into next command (follow)'$'\n''- '$'\e''[[(code)]mq'$'\e''[[(reset)]m         - Quit debugger (and continue execution)'$'\n''- '$'\e''[[(code)]m!'$'\e''[[(reset)]m         - Enter a command to execute'$'\n'''$'\n''### Watching'$'\n'''$'\n''- '$'\e''[[(code)]mw'$'\e''[[(reset)]m         - Enter a watch expression'$'\n''- '$'\e''[[(code)]mu'$'\e''[[(reset)]m         - Remove a watch expression'$'\n'''$'\n''### Utilities'$'\n'''$'\n'''$'\e''[[(code)]mk'$'\e''[[(reset)]m         - Display call stack'$'\n'''$'\e''[[(code)]m'$'\e''[[(cyan)]m'$'\e''[[(reset)]m         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)'$'\e''[[(reset)]m'$'\n'''$'\e''[[(code)]mh'$'\e''[[(reset)]m or '$'\e''[[(code)]m?'$'\e''[[(reset)]m  - This help'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashDebug commandToDebug ... [ --help ]'$'\n'''$'\n''    commandToDebug ...  Callable. Required. Command to debug.'$'\n''    --help              Flag. Optional. Display this help.'$'\n'''$'\n''bashDebug: Simple debugger to walk through a program.'$'\n'''$'\n''Debugger accepts the following keystrokes:'$'\n'''$'\n''### Flow control'$'\n'''$'\n''- . or   or Return - Repeat last flow command'$'\n'''$'\n''- j         - Skip next command (jump over)'$'\n''- s or n  - Step to next command (step)'$'\n''- i or d  - Step into next command (follow)'$'\n''- q         - Quit debugger (and continue execution)'$'\n''- !         - Enter a command to execute'$'\n'''$'\n''### Watching'$'\n'''$'\n''- w         - Enter a watch expression'$'\n''- u         - Remove a watch expression'$'\n'''$'\n''### Utilities'$'\n'''$'\n''k         - Display call stack'$'\n''         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)'$'\n''h or ?  - This help'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/debug.md"
