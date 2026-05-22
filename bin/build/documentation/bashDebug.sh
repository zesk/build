#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-22
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
foundNames=([0]="summary" [1]="usage" [2]="argument")
line="43"
rawComment="Summary: Bash debugger"$'\n'"\`{fn}\`: Simple debugger to walk through a program."$'\n'"Usage:     bashDebug command"$'\n'"Argument: commandToDebug ... - Callable. Required. Command to debug."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Debugger accepts the following keystrokes:"$'\n'"### Flow control"$'\n'"- \`.\` or \` \` or Return - Repeat last flow command"$'\n'"- \`j\`         - Skip next command (jump over)"$'\n'"- \`s\` or \`n\`  - Step to next command (step)"$'\n'"- \`i\` or \`d\`  - Step into next command (follow)"$'\n'"- \`q\`         - Quit debugger (and continue execution)"$'\n'"- \`!\`         - Enter a command to execute"$'\n'"### Watching"$'\n'"- \`w\`         - Enter a watch expression"$'\n'"- \`u\`         - Remove a watch expression"$'\n'"### Utilities"$'\n'"\`k\`         - Display call stack"$'\n'"\`*\`         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)"$'\n'"\`h\` or \`?\`  - This help"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceHash="88503835f6348f148bb8f4c15fc6b863517030bb"
sourceLine="43"
summary="Bash debugger"
summaryComputed=""
usage="    bashDebug command"$'\n'""
