### `decorations`

> Output a list of build-in decoration styles, one per line

#### Usage

    decorations [ --help ]

Output a list of build-in decoration styles, one per line

> Location: `bin/build/tools/decorate/core.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [convertValue]({rel}tools/sugar-core.md#convertvalue) - map a value from one value to another given from-to ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L161))

