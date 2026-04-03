## `usageArgumentApplicationDirectoryList`

> Validates a value as an application-relative directory search list. Upon

### Usage

    usageArgumentApplicationDirectoryList usageFunction variableName variableValue [ noun ]

Validates a value as an application-relative directory search list. Upon success, outputs the entire list, cleans up any invalid values or trailing characters.

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Required. only in that if it's blank, it fails.
- `noun` - String. Optional. Noun used to describe the argument in errors, defaults to `directory list`

### Return codes

- `2` - Argument error
- `0` - Success

