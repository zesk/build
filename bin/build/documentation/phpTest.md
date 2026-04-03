## `phpTest`

> Test a docker-based PHP application during build

### Usage

    phpTest [ --env-file envFile ] [ --home homeDirectory ]

Test a docker-based PHP application during build

### Arguments

- `--env-file envFile` - File. Optional. Environment file to load.
- `--home homeDirectory` - Directory. Optional. Directory for application home.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

