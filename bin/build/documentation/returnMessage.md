## `returnMessage`

> Return passed in integer return code and output message to

### Usage

    returnMessage exitCode [ message ... ]

Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)

### Arguments

- `exitCode` - UnsignedInteger. Required. Exit code to return. Default is 1.
- `message ...` - String. Optional. Message to output

### Return codes

- exitCode

### Requires

isUnsignedInteger printf returnMessage

