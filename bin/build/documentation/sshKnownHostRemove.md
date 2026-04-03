## `sshKnownHostRemove`

> Adds the host to the `~/.known_hosts` if it is not

### Usage

    sshKnownHostRemove [ hostName ... ] [ --skip-backup | --no-backup ] [ --verbose ]

Adds the host to the `~/.known_hosts` if it is not found in it already
Side effects:
1. `~/.ssh` may be created if it does not exist
1. `~/.ssh` mode is set to `0700` (read/write/execute user)
1. `~/.ssh/known_hosts` is created if it does not exist
1. `~/.ssh/known_hosts` mode is set to `0600` (read/write user)
1. `~./.ssh/known_hosts` is possibly modified (appended)
If this function fails then ~/.ssh/known_hosts may be modified for any hosts which did not fail
If no arguments are passed, the default behavior is to set up the `~/.ssh` directory and create the known hosts file.

### Arguments

- `hostName ...` - String. Optional. One ore more hosts to add to the known hosts file
--skip-backup |- ` --no-backup` - Flag. Optional. Skip the file backup as `name.$(dateToday)`
- `--verbose` - Flag. Optional. Be verbose.

### Return codes

- `1` - Environment errors
- `0` - All hosts exist in or were successfully added to the known hosts file

