### `catchEnvironment`

> Run `command`, upon failure run `handler` with an environment error

#### Usage

    catchEnvironment handler command ... [ ... ]

Run `command`, upon failure run `handler` with an environment error

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `handler` - String. Required. Failure command
- `command ...` - Callable. Required. Command to run.
- `...` - Arguments. Optional. Arguments to `command`

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [catchCode]({rel}tools/sugar-core.md#catchcode) - Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L194))

