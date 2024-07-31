# SSH Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `sshAddKnownHost` - Adds the host to the `~/.known_hosts` if it is not

Adds the host to the `~/.known_hosts` if it is not found in it already

Side effects:
1. `~/.ssh` may be created if it does not exist
1. `~/.ssh` mode is set to `0700` (read/write/execute user)
1. `~/.ssh/known_hosts` is created if it does not exist
1. `~/.ssh/known_hosts` mode is set to `0600` (read/write user)
1. `~./.ssh/known_hosts` is possibly modified (appended)

If this function fails then ~/.ssh/known_hosts may be modified for any hosts which did not fail



If no arguments are passed, the default behavior is to set up the `~/.ssh` directory and create the known hosts file.

#### Usage

    sshAddKnownHost [ host0 ]
    

#### Arguments



#### Exit codes

- `1` - Environment errors
- `0` - All hosts exist in or were successfully added to the known hosts file

### `sshSetup` - Set up SSH for a user with ID and backup

Set up SSH for a user with ID and backup keys in `~/.ssh`

Create a key for a user for SSH authentication to other servers.


Add .ssh key for current user


You will need the password for this server for the current user.

#### Usage

    sshSetup [ --force ] [ server ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds
