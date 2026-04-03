## `environmentRequire`

> Requires environment variables to be set and non-blank

### Usage

    environmentRequire usageFunction [ environmentVariable ]

Requires environment variables to be set and non-blank

### Arguments

- `usageFunction` - Required. `bash` function already defined to output handler
- `environmentVariable` - String. Optional. One or more environment variables which should be set and non-empty.

### Return codes

- `0` - All environment variables are set and non-empty
- `1` - If any `environmentVariable` variables are not set or are empty.

