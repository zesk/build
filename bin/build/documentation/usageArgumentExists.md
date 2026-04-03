## `usageArgumentExists`

> Validates a value is not blank and exists in the

### Usage

    usageArgumentExists usageFunction variableName variableValue [ noun ]

Validates a value is not blank and exists in the file system
Upon success, outputs the file name

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Required. only in that if it's blank, it fails.
- `noun` - String. Optional. Noun used to describe the argument in errors, defaults to `file or directory`

### Return codes

- `2` - Argument error
- `0` - Success

