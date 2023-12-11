# Docker Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `dumpDockerTestFile` - Debugging, dumps the proc1file which is used to figure out

Debugging, dumps the proc1file which is used to figure out if we
are insideDocker or not; use this to confirm platform implementation

#### Exit codes

- `0` - Always succeeds

### `insideDocker` - Are we inside a docker container right now?

Are we inside a docker container right now?

#### Exit codes

- `0` - Yes
- `1` - No

### `checkDockerEnvFile` - Ensure an environment file is compatible with non-quoted docker environment

Ensure an environment file is compatible with non-quoted docker environment files

#### Usage

    checkDockerEnvFile [ filename ... ]

#### Arguments

- `filename` - Docker environment file to check for common issues

#### Exit codes

- `1` - if errors occur
- `0` - if file is valid

### `docker.sh` - Run a build container using given docker image.

Run a build container using given docker image.

Runs ARM64 by default.

#### Arguments

- `imageName` - Required. String. Docker image name to run.
- `imageApplicationPath` - Path. Docker image path to map to current directory.
- `envFile` - Optional. File. One or more environment files which are suitable to load for docker; must be valid
- `extraArgs` - Optional. Mixed. The first non-file argument to `docker.sh` is passed directly through to `docker run` as arguments

#### Exit codes

- `1` - If already inside docker, or the environment file passed is not valid
- `0` - Success
- `Any` - `docker run` error code is returned if non-zero

#### Environment

BUILD_DOCKER_PLATFORM - Optional. Defaults to `linux/arm64`. Affects which image platform is used.

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
