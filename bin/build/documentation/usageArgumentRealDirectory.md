## `usageArgumentRealDirectory`

> Validates a value is not blank and is a directory

### Usage

    usageArgumentRealDirectory usageFunction variableName variableValue [ noun ]

Validates a value is not blank and is a directory and does `fileRealPath` on it.

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Required. only in that if it's blank, it fails.
- `noun` - String. Optional. Noun used to describe the argument in errors, defaults to `directory`

### Return codes

- `2` - Argument error
- `0` - Success

