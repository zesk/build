## `isPositiveInteger`

> Test if an argument is a positive integer (non-zero)

### Usage

    isPositiveInteger value [ --help ]

Test if an argument is a positive integer (non-zero)
Takes one argument only.

### Arguments

- `value` - EmptyString. Required. Value to check if it is an unsigned integer
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - if it is a positive integer
- `1` - if it is not a positive integer

### Requires

catchArgument isUnsignedInteger bashDocumentation __help

