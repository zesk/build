### `debuggingStack`

> Dump the function and include stacks and the current environment

#### Usage

    debuggingStack [ -x ] [ --me ] [ --exit ]

Dump the function and include stacks and the current environment

> Location: `bin/build/tools/dump.sh`

#### Arguments

- `-x` - Flag. Optional. Show exported variables. (verbose)
- `--me` - Flag. Optional. Show calling function call stack frame.
- `--exit` - Flag. Optional. Exit with code 0 after output.

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `debuggingStack` - `debuggingStack` shows arguments passed (extra) and exports (optional flag) ALWAYS

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- {SEE:BUILD_DEBUG}

#### Requires

- [`printf`]({rel}guide/builtin.md#printf)
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- {SEE:throwArgument}

