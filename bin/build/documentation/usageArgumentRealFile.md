## `usageArgumentRealFile`

> Validates a value is not blank and is a file

### Usage

    usageArgumentRealFile usageFunction variableName variableValue [ noun ]

Validates a value is not blank and is a file and does `fileRealPath` on it.

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Value to test.
- `noun` - String. Optional. Noun used to describe the argument in errors, defaults to `file`

### Return codes

- `2` - Argument error
- `0` - Success

