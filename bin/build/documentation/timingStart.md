### `timingStart`

> Start a timer

#### Usage

    timingStart [ --help ]

Outputs the offset in milliseconds from midnight UTC January 1, 1970.

Only fails if `date` is not installed

> Location: `bin/build/tools/timing.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Writes to standard output

UnsignedInteger

#### Sample Output

1777501474602

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- __timestamp,
- [returnEnvironment]({rel}tools/sugar-core.md#returnenvironment) - Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L265))
- [`date`]({rel}guide/command.md#date)

