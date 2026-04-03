## `environmentFileApplicationMake`

> Create environment file `.env` for build.

### Usage

    environmentFileApplicationMake [ --help ] [ requiredVariable ... ] [ -- ] [ optionalVariable ... ]

Create environment file `.env` for build.
Note that this does NOT change or modify the current environment.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `requiredVariable ...` - EnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the `.env` file.
- `--` - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once.
- `optionalVariable ...` - EnvironmentVariable. Optional. One or more environment variables which are included if blank or not

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:APPLICATION_VERSION.sh} - reserved and set to `hookRun version-current` if not set already
- {SEE:APPLICATION_BUILD_DATE.sh} - reserved and set to current date; format like SQL.
- {SEE:APPLICATION_TAG.sh} - reserved and set to `hookRun application-id`
- {SEE:APPLICATION_ID.sh} - reserved and set to `hookRun application-tag`

