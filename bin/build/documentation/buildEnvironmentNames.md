### `buildEnvironmentNames`

> List known environment names

#### Usage

    buildEnvironmentNames [ --help ]

Environment:
Output the list of environment variable names which can be loaded via `buildEnvironmentLoad` or `buildEnvironmentGet`

> Location: `bin/build/tools/build.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- {SEE:BUILD_ENVIRONMENT_DIRS} {SEE:BUILD_HOME}

#### Requires

- {SEE:convertValue}
- [`find`]({rel}guide/command.md#find)
- [`sort`]({rel}guide/command.md#sort)
- [`read`]({rel}guide/builtin.md#read)
- {SEE:helpArgument}
- {SEE:catchReturn}

