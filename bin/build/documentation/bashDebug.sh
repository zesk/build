#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
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
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceModified="1768761768"
summary="{fn}: Simple debugger to walk through a program"
usage="bashDebug commandToDebug"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashDebug[0m [38;2;255;255;0m[35;48;2;0;0;0mcommandToDebug[0m[0m

    [31mcommandToDebug  [1;97mCallable. Required. Command to debug.[0m

bashDebug: Simple debugger to walk through a program

    Usage: bashDebug [ --help ] commandToDebug ...


Debugger accepts the following keystrokes:

### Flow control

- [38;2;0;255;0;48;2;0;0;0m.[0m or [38;2;0;255;0;48;2;0;0;0m [0m or Return - Repeat last flow command

- [38;2;0;255;0;48;2;0;0;0mj[0m         - Skip next command (jump over)
- [38;2;0;255;0;48;2;0;0;0ms[0m or [38;2;0;255;0;48;2;0;0;0mn[0m  - Step to next command (step)
- [38;2;0;255;0;48;2;0;0;0mi[0m or [38;2;0;255;0;48;2;0;0;0md[0m  - Step into next command (follow)
- [38;2;0;255;0;48;2;0;0;0mq[0m         - Quit debugger (and continue execution)
- [38;2;0;255;0;48;2;0;0;0m![0m         - Enter a command to execute

### Watching

- [38;2;0;255;0;48;2;0;0;0mw[0m         - Enter a watch expression
- [38;2;0;255;0;48;2;0;0;0mu[0m         - Remove a watch expression

### Utilities

[38;2;0;255;0;48;2;0;0;0mk[0m         - Display call stack
[38;2;0;255;0;48;2;0;0;0m[36m[0m         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)[0m
[38;2;0;255;0;48;2;0;0;0mh[0m or [38;2;0;255;0;48;2;0;0;0m?[0m  - This help

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashDebug commandToDebug

    commandToDebug  Callable. Required. Command to debug.

bashDebug: Simple debugger to walk through a program

    Usage: bashDebug [ --help ] commandToDebug ...


Debugger accepts the following keystrokes:

### Flow control

- . or   or Return - Repeat last flow command

- j         - Skip next command (jump over)
- s or n  - Step to next command (step)
- i or d  - Step into next command (follow)
- q         - Quit debugger (and continue execution)
- !         - Enter a command to execute

### Watching

- w         - Enter a watch expression
- u         - Remove a watch expression

### Utilities

k         - Display call stack
         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)
h or ?  - This help

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
