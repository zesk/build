#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
### Flow control
### Watching
### Utilities
applicationFile="bin/build/tools/debugger.sh"
argument="commandToDebug - Callable. Required. Command to debug."$'\n'""
base="debugger.sh"
description="{fn}: Simple debugger to walk through a program"$'\n'""$'\n'"    Usage: {fn} [ --help ] commandToDebug ..."$'\n'""$'\n'""$'\n'"Debugger accepts the following keystrokes:"$'\n'""$'\n'"### Flow control"$'\n'""$'\n'"- \`.\` or \` \` or Return - Repeat last flow command"$'\n'""$'\n'"- \`j\`         - Skip next command (jump over)"$'\n'"- \`s\` or \`n\`  - Step to next command (step)"$'\n'"- \`i\` or \`d\`  - Step into next command (follow)"$'\n'"- \`q\`         - Quit debugger (and continue execution)"$'\n'"- \`!\`         - Enter a command to execute"$'\n'""$'\n'"### Watching"$'\n'""$'\n'"- \`w\`         - Enter a watch expression"$'\n'"- \`u\`         - Remove a watch expression"$'\n'""$'\n'"### Utilities"$'\n'""$'\n'"\`k\`         - Display call stack"$'\n'"\`*\`         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)"$'\n'"\`h\` or \`?\`  - This help"$'\n'""$'\n'""
file="bin/build/tools/debugger.sh"
fn="bashDebug"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/debugger.sh"
sourceModified="1768761768"
summary="{fn}: Simple debugger to walk through a program"
usage="bashDebug commandToDebug"
