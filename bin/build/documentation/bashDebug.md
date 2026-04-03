### Usage

    bashDebug commandToDebug

bashDebug: Simple debugger to walk through a program
Debugger accepts the following keystrokes:
### Flow control
- `.` or ` ` or Return - Repeat last flow command
- `j`         - Skip next command (jump over)
- `s` or `n`  - Step to next command (step)
- `i` or `d`  - Step into next command (follow)
- `q`         - Quit debugger (and continue execution)
- `!`         - Enter a command to execute
### Watching
- `w`         - Enter a watch expression
- `u`         - Remove a watch expression
### Utilities
`k`         - Display call stack
`*`         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)
`h` or `?`  - This help

### Arguments

- `commandToDebug` - Callable. Required. Command to debug.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

