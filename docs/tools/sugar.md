# Sugar Extensions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Usage Sugar

See [Sugar Core](_sugar.md) first.

This groupings of functions are related to a `usage` function to handle errors:

- `__usage code usageFunction command ...` - Run `command ...`, and if it fails invoke `usageFunction` with `code` and command arguments.
- `__usageEnvironment usageFunction command ...` - Run `command ...` and if it fails invoke `usageFunction` with an environment error.
- `__usageArgument usageFunction command ...` - Run `command ...` and if it fails invoke `usageFunction` with an argument error.
- `__failEnvironment usageFunction message ...` - Run `usageFunction` with an environment error and `message ...` arguments.
- `__failArgument usageFunction message ...` - Run `usageFunction` with an argument error and `message ...` arguments.

## Usage Sugar References

### `__execute` - IDENTICAL __execute 9

IDENTICAL __execute 9
Run binary and output failed command upon error
Unlike `_sugar.sh`'s `__execute`, this does not depend on `_command`.

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- `binary` - Required. Executable.
- `...` - Any arguments are passed to binary

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `__usage` - Run `command`, handle failure with `usage` with `code` and `command`

Run `command`, handle failure with `usage` with `code` and `command` as error

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- `code` - Required. Integer. Exit code to return
- `usage` - Required. String. Failure command, passed remaining arguments and error code.
- `command` - Required. String. Command to run.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `__usageEnvironment` - Run `command`, upon failure run `usage` with an environment error

Run `command`, upon failure run `usage` with an environment error

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- `usage` - Required. String. Failure command
- `command` - Required. Command to run.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `__usageEnvironmentQuiet` - Run `usage` with an environment error

Run `usage` with an environment error

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `__usageArgument` - Run `command`, upon failure run `usage` with an argument error

Run `command`, upon failure run `usage` with an argument error

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- `usage` - Required. String. Failure command
- `command` - Required. Command to run.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `__failEnvironment` - Run `usage` with an environment error

Run `usage` with an environment error

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `__failArgument` - Run `usage` with an argument error

Run `usage` with an argument error

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `_undo` - Run a function and preserve exit code

Run a function and preserve exit code
Returns `exitCode`
As a caveat, your command to `undo` can NOT take the argument `--` as a parameter.

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- `exitCode` - Required. Integer. Exit code to return.
- `undoFunction` - Optional. Command to run to undo something. Return status is ignored.
- `--` - Flag. Optional. Used to delimit multiple commands.

#### Examples

local undo thing
thing=$(__usageEnvironment "$usage" createLargeResource) || return $?
undo+=(-- deleteLargeResource "$thing")
thing=$(__usageEnvironment "$usage" createMassiveResource) || _undo $? "${undo[@]}" || return $?
undo+=(-- deleteMassiveResource "$thing")

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `muzzle` - Suppress stdout without piping. Handy when you just want a

Suppress stdout without piping. Handy when you just want a behavior not the output. e.g. `muzzle pushd`

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- `command` - Required. Callable. Thing to muzzle.
- `...` - Optional. Arguments. Additional arguments.

#### Examples

    muzzle pushd
    __usageEnvironment "$usage" phpBuild || _undo $? muzzle popd || return $?

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Deprecated Logging

### `_deprecated` - Logs all deprecated functions to application root in a file

Logs all deprecated functions to application root in a file called `.deprecated`

- Location: `bin/build/tools/sugar.sh`

#### Arguments

- `function` - Required. String. Function which is deprecated.

#### Examples

    _deprecated "${FUNCNAME[0]}"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
