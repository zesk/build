### `plumber`

> Run command and detect any global or local leaks

#### Usage

    plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]

Run command and detect any global or local leaks

> Location: `bin/build/tools/debug.sh`

#### Arguments

- `command ...` - Callable. Command to run
- `--temporary tempPath` - Directory. Optional. Use this for the temporary path.
- `--leak envName ...` - EnvironmentVariable. Variable name which is OK to leak.
- `--verbose` - Flag. Optional. Be verbose.
- `--help` - Flag. Optional. Display this help.

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `plumber-verbose` - The plumber outputs the exact variable captures before and after
- `plumber-verbose` - The plumber outputs the exact variable captures before and after

#### Return codes

- `0` - No leaks detected in the command
- `108` - A leak was detected in the command
- `1` - Argument error, plumber was called incorrectly.

#### Requires

- [`declare`]({rel}/guide/builtin.md#declare)
- diff
- grep
- {SEE:throwArgument}
- {SEE:decorate}
- {SEE:validate}
- {SEE:isCallable}
- {SEE:fileTemporaryName}
- {SEE:textRemoveFields}

