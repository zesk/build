### `timingElapsed`

> Show elapsed time from a start time

#### Usage

    timingElapsed timingOffset [ --help ]

Show elapsed time from a start time

> Location: `bin/build/tools/timing.sh`

#### Arguments

- `timingOffset` - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970.
- `--help` - Flag. Optional. Display this help.

#### Writes to standard output

UnsignedInteger

#### Examples

    init=$(timingStart)
    ...
    timingElapsed "$init"

#### Sample Output

4232

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [returnEnvironment]({rel}tools/sugar-core.md#returnenvironment) - Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L265))
- [validate]({rel}tools/validate.md#validate) - Validate a value by type ([source](https://github.com/zesk/build/blob/main/bin/build/tools/validate.sh#L95))
- [`date`]({rel}guide/command.md#date)

