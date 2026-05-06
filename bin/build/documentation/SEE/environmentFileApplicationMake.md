## `environmentFileApplicationMake`

> Create environment file `.env` for build.

### Usage

    environmentFileApplicationMake [ --help ] [ requiredVariable ... ] [ -- ] [ optionalVariable ... ]

Create environment file `.env` for build.

Note that this does NOT change or modify the current environment.

> Location: `bin/build/tools/environment/application.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.
- `requiredVariable ...` - EnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the `.env` file.
- `--` - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once.
- `optionalVariable ...` - EnvironmentVariable. Optional. One or more environment variables which are included if blank or not

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

