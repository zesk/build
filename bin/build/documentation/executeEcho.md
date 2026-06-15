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

- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- [execute]({rel}tools/sugar-core.md#execute) - Run binary and output failed command upon error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L140))
- {SEE:__decorateExtensionQuote}
- {SEE:__decorateExtensionEach}

