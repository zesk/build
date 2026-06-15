### `directoryRequire`

> Given a list of directories, ensure they exist and create

#### Usage

    directoryRequire [ directoryPath ... ] [ --help ] [ --mode fileMode ] [ --owner ownerName ]

Given a list of directories, ensure they exist and create them if they do not.

> Location: `bin/build/tools/directory.sh`

#### Arguments

- `directoryPath ...` - One or more directories to create
- `--help` - Flag. Optional. Display this help.
- `--mode fileMode` - String. Optional. Enforce the directory mode for `mkdir --mode` and `chmod`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to `-` to reset to no value.
- `--owner ownerName` - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to `-` to reset to no value.

#### Examples

    directoryRequire "$cachePath"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))[decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))[catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))dirname
- chmod
- chown

