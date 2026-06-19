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

- [`BUILD_ENVIRONMENT_DIRS` Build Environment Directory List]({rel}env/#build_configuration) – **DirectoryList**. Search directory for environment definition files. `:` separated. [`BUILD_HOME` Build Home Directory]({rel}env/#build_configuration) – **Directory**. `BUILD_HOME` is `.` when this code is installed - at

#### Requires

- [convertValue]({rel}tools/sugar-core.md#convertvalue) - map a value from one value to another given from-to ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L161))
- [`find`]({rel}guide/command.md#find)
- [`sort`]({rel}guide/command.md#sort)
- [`read`]({rel}guide/builtin.md#read)
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [catchReturn]({rel}tools/sugar.md#catchreturn) - Run binary and catch errors with handler ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L284))

