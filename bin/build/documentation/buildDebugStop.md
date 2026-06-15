### `buildDebugStop`

> Stop bash debugging

#### Usage

    buildDebugStop [ --help ]

Stop bash debugging if it is enabled.

> Location: `bin/build/tools/debug.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - bash debugging was stopped
- `1` - bash debugging was not stopped because token did not match.

#### See Also

- [buildDebugStart]({rel}tools/debug.md#builddebugstart) - Start bash debugging ([source](https://github.com/zesk/build/blob/main/bin/build/tools/debug.sh#L96))

