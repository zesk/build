### `sshSetup`

> Set up SSH for a user with ID and backup

#### Usage

    sshSetup [ --force ] server

Set up SSH for a user with ID and backup keys in `~/.ssh`

Create a key for a user for SSH authentication to other servers.

Add .ssh key for current user

You will need the password for this server for the current user.

> Location: `bin/build/tools/ssh.sh`

#### Arguments

- `--force` - Flag. Optional. Force the program to create a new key if one exists
- `server` - String. Required. Servers to connect to to set up authorization

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- {SEE:userRecordHome}
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- {SEE:throwEnvironment}

