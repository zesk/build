## `usageArgumentPositiveInteger`

> Validates a value is an positive integer and greater than

### Usage

    usageArgumentPositiveInteger usageFunction variableName variableValue

Validates a value is an positive integer and greater than zero (NOT zero)

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Required. only in that if it's blank, it fails.

### Return codes

- `2` - Argument error
- `0` - Success

### Requires

isPositiveInteger throwArgument decorate

