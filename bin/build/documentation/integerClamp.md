## `integerClamp`

> Clamp digits between two integers

### Usage

    integerClamp [ minimum ] [ maximum ] [ --help ]

Clamp digits between two integers
Reads stdin digits, one per line, and outputs only integer values between $min and $max

### Arguments

- `minimum` - Integer|Empty. Minimum integer value to output.
- `maximum` - Integer|Empty. Maximum integer value to output.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

