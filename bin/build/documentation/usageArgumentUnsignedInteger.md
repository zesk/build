## `usageArgumentUnsignedInteger`

> Validates a value is an unsigned integer and greater than

### Usage

    usageArgumentUnsignedInteger usageFunction variableName variableValue [ noun ]

Validates a value is an unsigned integer and greater than zero (or equal to zero)

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Required. only in that if it's blank, it fails.
- `noun` - String. Optional. Noun used to describe the argument in errors, defaults to `unsigned integer`

### Return codes

- `2` - Argument error
- `0` - Success

### Requires

isUnsignedInteger throwArgument decorate

