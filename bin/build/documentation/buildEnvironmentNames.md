## `buildEnvironmentNames`

> Output the list of environment variable names which can be

### Usage

    buildEnvironmentNames [ --help ]

Output the list of environment variable names which can be loaded via `buildEnvironmentLoad` or `buildEnvironmentGet`

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

convertValue _buildEnvironmentPath find sort read __help catchEnvironment

