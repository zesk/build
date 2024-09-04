# Docker Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `dumpDockerTestFile` - Debugging, dumps the proc1file which is used to figure out

Debugging, dumps the proc1file which is used to figure out if we
are insideDocker or not; use this to confirm platform implementation

- Location: `bin/build/tools/docker.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `insideDocker` - Are we inside a docker container right now?

Are we inside a docker container right now?

- Location: `bin/build/tools/docker.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Yes
- `1` - No
### `checkDockerEnvFile` - Ensure an environment file is compatible with non-quoted docker environment

Ensure an environment file is compatible with non-quoted docker environment files

- Location: `bin/build/tools/docker.sh`

#### Usage

    checkDockerEnvFile [ filename ... ]
    

#### Arguments

- `filename` - Docker environment file to check for common issues

#### Exit codes

- `1` - if errors occur
- `0` - if file is valid
#### Exit codes

- `1` - If already inside docker, or the environment file passed is not valid
- `0` - Success
- `Any` - `docker run` error code is returned if non-zero

#### Environment

BUILD_DOCKER_PLATFORM - Optional. Defaults to `linux/arm64`. Affects which image platform is used.
### `dockerEnvFromBashEnv` - Ensure an environment file is compatible with non-quoted docker environment

Ensure an environment file is compatible with non-quoted docker environment files

- Location: `bin/build/tools/docker.sh`

#### Usage

    checkDockerEnvFile [ filename ... ]
    

#### Arguments

- `filename` - Docker environment file to check for common issues

#### Exit codes

- `1` - if errors occur
- `0` - if file is valid
### `dockerEnvToBash` - Ensure an environment file is compatible with non-quoted docker environment

Ensure an environment file is compatible with non-quoted docker environment files
May take a list of files to convert or stdin piped in

Outputs bash-compatible entries to stdout
Any output to stdout is considered valid output
Any output to stderr is errors in the file but is written to be compatible with a bash

- Location: `bin/build/tools/docker.sh`

#### Arguments

- `filename` - Docker environment file to check for common issues

#### Exit codes

- `1` - if errors occur
- `0` - if file is valid
### `anyEnvToBashEnv` - Takes any environment file and makes it bash-compatible

Takes any environment file and makes it bash-compatible

Returns a temporary file which should be deleted.

- Location: `bin/build/tools/docker.sh`

#### Arguments

- `filename` - Required. File. One or more files to convert.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `anyEnvToDockerEnv` - Takes any environment file and makes it docker-compatible

Takes any environment file and makes it docker-compatible

Returns a temporary file which should be deleted.

- Location: `bin/build/tools/docker.sh`

#### Arguments

- `filename` - Required. File. One or more files to convert.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
