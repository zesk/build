## `usageArgumentEnvironmentVariable`

> Validates a value is ok for an environment variable name

### Usage

    usageArgumentEnvironmentVariable usageFunction variableName variableValue [ noun ]

Validates a value is ok for an environment variable name
Upon success, outputs the name

### Arguments

- `usageFunction` - Function. Required. Run if handler fails
- `variableName` - String. Required. Name of variable being tested
- `variableValue` - String. Required. Environment variable name.
- `noun` - String. Optional. Noun used to describe the argument in errors, defaults to `environment variable`

### Return codes

- `2` - Argument error
- `0` - Success

