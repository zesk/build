### `executeEcho`

> Output the `command ...` to stdout prior to running, then

#### Usage

    executeEcho [ command ... ] [ --help ]

Output the `command ...` to stdout prior to running, then `execute` it

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `command ...` - Any command and arguments to run.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- Any

#### Requires

- {SEE:helpArgument}
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [execute]({rel}tools/sugar-core.md#execute) - Run binary and output failed command upon error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L140))

