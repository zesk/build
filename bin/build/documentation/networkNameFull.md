### `networkNameFull`

> Platform-agnostic host name

#### Usage

    networkNameFull

Get the full hostname on the current platform.
Formerly `hostname``Full`.

> Location: `bin/build/tools/host.sh`

#### Arguments

- none

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- {SEE:__hostname}
- [executableRequire]({rel}tools/usage.md#executablerequire) - Check that one or more binaries are installed ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L232))
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))

