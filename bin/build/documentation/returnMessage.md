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

- {SEE:isUnsignedInteger}
- [`printf`]({rel}/guide/builtin.md#printf)
- {SEE:returnMessage}

