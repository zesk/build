## `usageArgumentLink`

> Validates a value is not blank and is a link

### Usage

    usageArgumentLink usageFunction variableName variableValue [ noun ]

Validates a value is not blank and is a link
Upon success, outputs the file name

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Path to a link file.
- `noun` - String. Optional. Noun used to describe the argument in errors, defaults to `link`

### Return codes

- `2` - Argument error
- `0` - Success

