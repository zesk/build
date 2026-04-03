## `isValidateType`

> Are all arguments passed a valid validate type?

### Usage

    isValidateType [ --help ] [ type ]

Are all arguments passed a valid validate type?

### Arguments

- `--help` - Flag. Optional. Display this help.
- `type` - String. Optional. Type to validate as `validate` type.

### Examples

    isValidateType string || returnMessage 1 "string is not a type."

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

