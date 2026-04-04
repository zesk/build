## `__usageMessage`

> Output the message for usage consistently

### Usage

    __usageMessage [ returnCode ] [ message ... ]

Output the message for usage consistently

### Arguments

- `returnCode` - UnsignedInteger. Optional. Exit code to possibly display with message.
- `message ...` - String. Optional. Display this message which describes why `exitCode` occurred.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

