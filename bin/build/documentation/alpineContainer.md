## `alpineContainer`

> Open an Alpine container shell

### Usage

    alpineContainer [ --help ] [ --env-file envFile ] [ --env envVariable=envValue ] [ --platform platform ] [ extraArgs ]

Open an Alpine container shell

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--env-file envFile` - File. Optional. One or more environment files which are suitable to load for docker; must be valid
--env envVariable=- `envValue` - File. Optional. One or more environment variables to set.
- `--platform platform` - String. Optional. Platform to run (arm vs intel).
- `extraArgs` - Mixed. Optional. The first non-file argument to `alpineContainer` is passed directly through to `docker run` as arguments

### Return codes

- `1` - If already inside docker, or the environment file passed is not valid
- `0` - Success
- `Any` - `docker run` error code is returned if non-zero

