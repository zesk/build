### `executableExists`

> Does a binary exist in the PATH?

#### Usage

    executableExists [ --any ] binary ... [ --help ]

Does a binary exist in the PATH?

> Location: `bin/build/tools/platform.sh`

#### Arguments

- `--any` - Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist.
- `binary ...` - String. Required. One or more Binaries to find in the system `PATH`.
- `--help` - Flag. Optional. Display this help.

#### Examples

    executableExists cp date aws ls mv stat || throwEnvironment "$handler" "Need basic environment to work" || return $?
    executableExists --any terraform tofu || throwEnvironment "$handler" "No available infrastructure providers" || return $?
    executableExists --any curl wget || throwEnvironment "$handler" "No way to download URLs easily" || return $?

#### Return codes

- `0` - If all values are found (without the `--any` flag), or if *any* binary is found with the `--any` flag
- `1` - If any value is not found (without the `--any` flag), or if *all* binaries are NOT found with the `--any` flag.

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- {SEE:__decorateExtensionEach}
- [`command`]({rel}guide/builtin.md#command)

