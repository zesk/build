### `dockerComposeCommandIsValid`

> Validate docker compose subcommands

#### Usage

    dockerComposeCommandIsValid command [ --help ]

Is this a docker compose command?

> Location: `bin/build/tools/docker-compose.sh`

#### Arguments

- `command` - String. Required. The command to test.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Yes, it is.
- `1` - No, it is not.

#### See Also

- [dockerComposeCommandList]({rel}tools/docker-compose.md#dockercomposecommandlist) - List of docker compose commands ([source](https://github.com/zesk/build/blob/main/bin/build/tools/docker-compose.sh#L107))

