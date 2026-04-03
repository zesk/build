## `dockerLocalContainer`

> Run a build container using given docker image.

### Usage

    dockerLocalContainer [ --help ] [ --handler handler ] [ --image imageName ] [ --path imageApplicationPath ] [ --platform platform ] [ --env-file envFile ] [ --env envVariable=envValue ] [ extraArgs ]

Run a build container using given docker image.
Runs ARM64 by default.
- `BUILD_DOCKER_PLATFORM` defaults to `linux/arm64` – affects which image platform is used.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--image imageName` - String. Optional. Docker image name to run. Defaults to `BUILD_DOCKER_IMAGE`.
- `--path imageApplicationPath` - Path. Docker image path to map to current directory. Defaults to `BUILD_DOCKER_PATH`.
- `--platform platform` - String. Optional. Platform to run (arm vs intel).
- `--env-file envFile` - File. Optional. One or more environment files which are suitable to load for docker; must be valid
--env envVariable=- `envValue` - File. Optional. One or more environment variables to set.
- `extraArgs` - Mixed. Optional. The first non-file argument to `dockerLocalContainer` is passed directly through to `docker run` as arguments

### Return codes

- `1` - If already inside docker, or the environment file passed is not valid
- `0` - Success
- `Any` - `docker run` error code is returned if non-zero

### Environment

- {SEE:BUILD_DOCKER_PLATFORM.sh}

