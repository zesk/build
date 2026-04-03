## `usageArgumentNumber`

> Validates a value is a number

### Usage

    usageArgumentNumber usageFunction variableName variableValue [ noun ]

Validates a value is a number

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Required. only in that if it's blank, it fails.
- `noun` - String. Optional. Noun used to describe the argument in errors, defaults to `integer`

### Return codes

- `2` - Argument error
- `0` - Success

