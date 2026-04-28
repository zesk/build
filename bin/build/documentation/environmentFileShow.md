## `environmentFileShow`

> Display and validate application variables.

### Usage

    environmentFileShow [ environmentName ... ] [ -- ] [ optionalEnvironmentName ... ]

Display and validate application variables.

### Arguments

- `environmentName ...` - EnvironmentVariable. Optional. A required environment variable name
- `--` - Separator. Optional. Separates requires from optional environment variables
- `optionalEnvironmentName ...` - EnvironmentVariable. Optional. An optional environment variable name.

### Return codes

- `1` - If any required application variables are blank, the function fails with an environment error
- `0` - All required application variables are non-blank

