## `usageArgumentLoadEnvironmentFile`

> Validates a value is not blank and is an environment

### Usage

    usageArgumentLoadEnvironmentFile usageFunction variableName variableValue [ noun ]

Validates a value is not blank and is an environment file which is loaded immediately.
Upon success, outputs the file name to stdout, outputs a console message to stderr

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Required. only in that if it's blank, it fails.
- `noun` - String. Optional. Noun used to describe the argument in errors, defaults to `file`

### Return codes

- `2` - Argument error
- `0` - Success

