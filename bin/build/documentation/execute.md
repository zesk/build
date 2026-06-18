### `execute`

> Run binary and output failed command upon error

#### Usage

    execute [ --help ] binary [ ... ]

Run binary and output failed command upon error

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `binary` - Callable. Required. Command to run.
- `...` - Arguments. Optional. Any arguments are passed to `binary`.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [returnMessage]({rel}tools/sugar-core.md#returnmessage) - Return passed in integer return code and output message to ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L143))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))

