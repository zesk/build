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
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))[`read`]({rel}guide/builtin.md#read)
- usageArgumentUnsignedInteger
- [packageWhich]({rel}tools/package.md#packagewhich) - Install tools using \`apt-get\` if they are not found ([source](https://github.com/zesk/build/blob/main/bin/build/tools/package.sh#L233))

