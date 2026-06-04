### `colorNormalize`

> Redistribute color values to make brightness adjustments more balanced

#### Usage

    colorNormalize [ --help ]

Redistribute color values to make brightness adjustments more balanced

> Location: `bin/build/tools/colors.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- bc
- {SEE:catchEnvironment}
- [`read`]({rel}/guide/builtin.md#read)
- usageArgumentUnsignedInteger
- {SEE:packageWhich}
- {SEE:__colorNormalize}

