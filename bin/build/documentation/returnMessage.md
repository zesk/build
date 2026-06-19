### `returnMessage`

> Return passed in integer return code and output message to

#### Usage

    returnMessage exitCode [ message ... ]

Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)

> Location: `bin/build/tools/example.sh`

#### Arguments

- `exitCode` - UnsignedInteger. Required. Exit code to return. Default is 1.
- `message ...` - String. Optional. Message to output

#### Return codes

- exitCode

#### Requires

- [isUnsignedInteger]({rel}tools/type.md#isunsignedinteger) - Is value an unsigned integer? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L163))
- [`printf`]({rel}guide/builtin.md#printf)
- [returnMessage]({rel}tools/sugar-core.md#returnmessage) - Return passed in integer return code and output message to ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L143))

