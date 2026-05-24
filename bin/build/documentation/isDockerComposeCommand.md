## `isDockerComposeCommand`

> Is this a docker compose command?

### Usage

    isDockerComposeCommand command [ --help ]

Is this a docker compose command?

> Location: `bin/build/tools/docker-compose.sh`

### Arguments

- `command` - String. Required. The command to test.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Yes, it is.
- `1` - No, it is not.

