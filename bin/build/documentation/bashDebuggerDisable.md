### `bashDebuggerDisable`

> Disable the debugger

#### Usage

    bashDebuggerDisable [ --help ]

Disables the debugger immediately.
Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively

> Location: `bin/build/tools/debugger.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### See Also

- [bashDebug]({rel}tools/debug.md#bashdebug) - Bash debugger ([source](https://github.com/zesk/build/blob/main/bin/build/tools/debugger.sh#L43))[bashDebuggerEnable]({rel}tools/debug.md#bashdebuggerenable) - Enable the debugger ([source](https://github.com/zesk/build/blob/main/bin/build/tools/debugger.sh#L63))

