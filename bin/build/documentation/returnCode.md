### `returnCode`

> Print one or more return codes by name.

#### Usage

    returnCode [ name ... ]

Print one or more return codes by name.

Known codes:

- `success` (0) - success!
- `environment` (1) - generic issue with environment
- `argument` (2) - issue with arguments
- `assert` (97) - assertion failed (ASCII 97 = `a`)
- `identical` (105) - identical check failed (ASCII 105 = `i`)
- `leak` (108) - function leaked globals (ASCII 108 = `l`)
- `timeout` (116) - timeout exceeded (ASCII 116 = `t`)
- `exit` - (120) exit function immediately (ASCII 120 = `x`)
- `not-found` - (127) command not found
- `user-interrupt` - (130) User interrupt (Ctrl-C)
- `interrupt` - (141) Interrupt signal
- `internal` - (253) internal errors

Unknown error code is 254, end of range is 255 which is not used. Use `returnCodeString` to get a string from an exit code integer.

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `name ...` - String. Optional. Exit code value to output.

#### Return codes

- `0` - success

#### Requires

- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))

#### See Also

- [stackoverflow.com](https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux)
- [returnCodeString]({rel}tools/sugar-core.md#returncodestring) - Output the exit code as a string ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L60))

