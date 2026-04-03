## `buildEnvironmentAdd`

> Adds an environment variable file to a project

### Usage

    buildEnvironmentAdd [ --help ] [ --force ] [ --quiet ] [ --verbose ] [ --value value ] environmentName ...

Adds an environment variable file to a project

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--force` - Flag. Optional. Replace the existing file if it exists or create it if it does not.
- `--quiet` - Flag. Optional. No status messages.
- `--verbose` - Flag. Optional. Display status messages.
- `--value value` - String. Optional. Set the value to this fixed string in the file. Only valid when a single `environmentName` is used.
- `environmentName ...` - EnvironmentName. Required. One or more environment variable names to add to this project.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

