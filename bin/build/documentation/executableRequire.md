## `executableRequire`

> Check that one or more binaries are installed

### Usage

    executableRequire usageFunction binary

Requires the binaries to be found via `which`
Runs `handler` on failure

### Arguments

- `usageFunction` - Required. `bash` function already defined to output handler
- `binary` - Required. Binary which must have a `which` path.

### Return codes

- `1` - If any `binary` is not available within the current path

