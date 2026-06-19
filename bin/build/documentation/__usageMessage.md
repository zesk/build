### `__usageMessage`

> Output the message for usage consistently

#### Usage

    __usageMessage [ returnCode ] [ message ... ]

Output the message for usage consistently

> Location: `bin/build/tools/usage.sh`

#### Arguments

- `returnCode` - UnsignedInteger. Optional. Exit code to possibly display with message.
- `message ...` - String. Optional. Display this message which describes why `exitCode` occurred.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- [returnCodeString]({rel}tools/sugar-core.md#returncodestring) - Output the exit code as a string ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L60))

