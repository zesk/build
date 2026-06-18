### `fileTemporaryName`

> Wrapper for `mktemp`. Generate a temporary file name, and fail

#### Usage

    fileTemporaryName handler [ --help ] [ ... ]

Wrapper for `mktemp`. Generate a temporary file name, and fail using a function

> Location: `bin/build/tools/file.sh`

#### Arguments

- `handler` - Function. Required. Function to call on failure. Function Type: returnMessage
- `--help` - Flag. Optional. Display this help.
- `...` - Arguments. Optional. Any additional arguments are passed through.

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `temp` - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`BUILD_DEBUG` Debugging Flag]({rel}env/#build_configuration) – **CommaDelimitedList**. Constant for turning debugging on during build to find errors

#### Requires

- [`mktemp`]({rel}guide/command.md#mktemp)
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))

