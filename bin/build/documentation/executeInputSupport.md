### `executeInputSupport`

> Support arguments and stdin as arguments to an executor

#### Usage

    executeInputSupport [ --help ] [ executor ... -- Required. The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial `--`. ] [ -- ] [ ... ]

Support arguments and stdin as arguments to an executor

> Location: `bin/build/tools/sugar.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- executor ... -- Required. The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial `--`.
- `--` - Alone after the executor forces `stdin` to be ignored. The `--` flag is also removed from the arguments passed to the executor.
- `...` - Any additional arguments are passed directly to the executor

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [catchReturn]({rel}tools/sugar.md#catchreturn) - Run binary and catch errors with handler ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L284))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))

