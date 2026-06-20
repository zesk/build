### `isPositiveInteger`

> Test if an argument is a positive integer (non-zero)

#### Usage

    isPositiveInteger value [ --help ]

Test if an argument is a positive integer (non-zero)
Takes one argument only.

> Location: `bin/build/tools/type.sh`

#### Arguments

- `value` - EmptyString. Required. Value to check if it is an unsigned integer
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - if it is a positive integer
- `1` - if it is not a positive integer

#### Requires

- [catchArgument]({rel}tools/sugar-core.md#catchargument) - Run \`command\`, upon failure run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L238))
- [isUnsignedInteger]({rel}tools/type.md#isunsignedinteger) - Is value an unsigned integer? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L163))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))

