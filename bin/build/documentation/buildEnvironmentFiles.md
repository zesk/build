## `buildEnvironmentFiles`

> Determine the environment file names for environment variables

### Usage

    buildEnvironmentFiles [ envName ] [ --application applicationHome ] [ --help ] [ --handler handler ]

Determine the environment file names for environment variables

### Arguments

- `envName` - String. Optional. Name of the environment value to find
- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_ENVIRONMENT_DIRS.sh}

