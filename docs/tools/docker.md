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



#### Exit codes

- `1` - if errors occur
- `0` - if file is valid

### `docker.sh` - Run a build container using given docker image.

Run a build container using given docker image.

Runs ARM64 by default.

#### Usage

    docker.sh imageName imageApplicationPath [ envFile ... ] [ extraArgs ... ]
    

#### Arguments



#### Exit codes

- `1` - If already inside docker, or the environment file passed is not valid
- `0` - Success
- `Any` - `docker run` error code is returned if non-zero

#### Environment

BUILD_DOCKER_PLATFORM - Optional. Defaults to `linux/arm64`. Affects which image platform is used.

### `dockerEnvFromBashEnv` - Ensure an environment file is compatible with non-quoted docker environment

Ensure an environment file is compatible with non-quoted docker environment files

#### Usage

    checkDockerEnvFile [ filename ... ]
    

#### Arguments



#### Exit codes

- `1` - if errors occur
- `0` - if file is valid

### `dockerEnvToBash` - Ensure an environment file is compatible with non-quoted docker environment

Ensure an environment file is compatible with non-quoted docker environment files
May take a list of files to convert or stdin piped in

Outputs bash-compatible entries to stdout
Any output to stdout is considered valid output
Any output to stderr is errors in the file but is written to be compatible with a bash

#### Usage

    dockerEnvToBash [ filename ... ]
    

#### Arguments



#### Exit codes

- `1` - if errors occur
- `0` - if file is valid

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
