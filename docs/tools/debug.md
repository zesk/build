# Debug Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `debuggingStack` - Dump the function and include stacks and the current environment

Dump the function and include stacks and the current environment

- Location: `bin/build/tools/debug.sh`

#### Usage

_mapEnvironment

#### Arguments

- `-x` - Optional. Flag. Show exported variables. (verbose)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `buildDebugEnabled` - Is build debugging enabled?

Is build debugging enabled?

- Location: `bin/build/tools/debug.sh`

#### Usage

_mapEnvironment

#### Arguments

- `moduleName` - Optional. String. If `BUILD_DEBUG` contains any token passed, debugging is enabled.

#### Examples

    BUILD_DEBUG=false # All debugging disabled
    BUILD_DEBUG= # All debugging disabled
    BUILD_DEBUG=usage,documentation # Debug usage and documentation calls

#### Exit codes

- `1` - Debugging is not enabled (for any module)
- `0` - Debugging is enabled

#### Environment

BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. `BUILD_DEBUG` may be a comma-separated list of modules to target debugging.
### `buildDebugStart` - Start build debugging if it is enabled.

Start build debugging if it is enabled.
This does `set -x` which traces and outputs every shell command
Use it to debug when you can not figure out what is happening internally.

`BUILD_DEBUG` can be a list of strings like `environment,assert` for example.
Example:     buildDebugStart || :

- Location: `bin/build/tools/debug.sh`

#### Usage

_mapEnvironment

#### Arguments

- `moduleName` - Optional. String. Only start debugging if debugging is enabled for ANY of the passed in modules.

#### Examples

    # ... complex code here
    buildDebugStop || :. -

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_DEBUG
### `buildDebugStop` - Stop build debugging if it is enabled

Stop build debugging if it is enabled

- Location: `bin/build/tools/debug.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `isBashDebug` - Returns whether the shell has the debugging flag set

Returns whether the shell has the debugging flag set

Useful if you need to temporarily enable or disable it.

- Location: `bin/build/tools/debug.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Depends

    -
    
### `isErrorExit` - Returns whether the shell has the error exit flag set

Returns whether the shell has the error exit flag set

Useful if you need to temporarily enable or disable it.

October 2024 - Does appear to be inherited by subshells

    set -e
    printf "$(isErrorExit; printf %d $?)"

Outputs `1` always

- Location: `bin/build/tools/debug.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `dumpPipe` - Dump a pipe with a title and stats

Dump a pipe with a title and stats

- Location: `bin/build/tools/test.sh`

#### Usage

_mapEnvironment

#### Arguments

- `--symbol symbol` - Optional. String. Symbol to place before each line. (Blank is ok).
- `--tail` - Optional. Flag. Show the tail of the file and not the head when not enough can be shown.
- `--head` - Optional. Flag. Show the head of the file when not enough can be shown. (default)
- `--lines` - Optional. UnsignedInteger. Number of lines to show.
- `--vanish file` - Optional. UnsignedInteger. Number of lines to show.
- `name` - Optional. String. The item name or title of this output.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `dumpBinary` - Dumps output as hex

Dumps output as hex

- Location: `bin/build/tools/test.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Depends

    xxd
    
### `dumpFile` - Output a file for debugging

Output a file for debugging

- Location: `bin/build/tools/test.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `plumber` - Run command and detect any global or local leaks

Run command and detect any global or local leaks

- Location: `bin/build/tools/debug.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `housekeeper` - Run a command and ensure files are not modified

Run a command and ensure files are not modified

- Location: `bin/build/tools/debug.sh`

#### Usage

_mapEnvironment

#### Arguments

- `--path path` - Optional. Directory. One or more directories to watch. If no directories are supplied uses current working directory.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `outputTrigger` - Check output for content and trigger environment error if found

Check output for content and trigger environment error if found
Usage outputTrigger [ --help ] [ --verbose ] [ --name name ]

- Location: `bin/build/tools/debug.sh`

#### Usage

_mapEnvironment

#### Arguments

- `--help` - Help
- `--verbose` - Optional. Flag. Verbose messages when no errors exist.
- `--name name` - Optional. String. Name for verbose mode.

#### Examples

    source "$include" > >(outputTrigger source "$include") || return $?

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Simple debugger

### `bashDebug` - Simple debugger to walk through a program

Simple debugger to walk through a program


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

- Location: `bin/build/tools/debugger.sh`

#### Usage

_mapEnvironment

#### Arguments

- `commandToDebug` - Callable. Required. Command to debug.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `bashDebuggerDisable` - Disables the debugger immediately

Disables the debugger immediately
Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively

- Location: `bin/build/tools/debugger.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `bashDebuggerEnable` - Enables the debugger immediately

Enables the debugger immediately
Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively

- Location: `bin/build/tools/debugger.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
