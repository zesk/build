## `environmentFileApplicationVerify`

> Check application environment is populated correctly.

### Usage

    environmentFileApplicationVerify [ --help ] [ requiredEnvironment ... ] [ -- ] [ optionalEnvironment ... ]

Check application environment is populated correctly.
Also verifies that `environmentApplicationVariables` and `environmentApplicationLoad` are defined.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `requiredEnvironment ...` - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the `.env` file.
- `--` - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment
- `optionalEnvironment ...` - EnvironmentName. Optional. One or more environment variables which are included if blank or not

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

