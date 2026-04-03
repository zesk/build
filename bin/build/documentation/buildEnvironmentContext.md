## `buildEnvironmentContext`

> Run a command and ensure the build tools context matches

### Usage

    buildEnvironmentContext contextStart command ...

Run a command and ensure the build tools context matches the current project
Avoid infinite loops here, call down.

### Arguments

- `contextStart` - Directory. Required. Context in which the command should run.
- `command ...` - Required. Command to run in new context.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

