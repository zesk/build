## `daemontoolsManager`

> Runs a daemon which monitors files and operates on services.

### Usage

    daemontoolsManager [ --home serviceHome ] [ --interval intervalSeconds ] [ --stat statFile ] [ --chirp chirpSeconds ] [ --action actions ] service0 file1

Runs a daemon which monitors files and operates on services.
To request a specific action write the file with the action as the first line.
Allows control across user boundaries. (e.g. user can control root services)
Specify actions more than once on the command line to specify more than one set of permissions.

### Arguments

- `--home serviceHome` - Directory. Optional. Service directory home. Defaults to `DAEMONTOOLS_HOME`.
- `--interval intervalSeconds` - PositiveInteger. Optional. Number of seconds to check for presence of the file. Defaults to 10.
- `--stat statFile` - FileDirectory. Optional. Output the `svstat` status to this file every `intervalSeconds`. If not specified nothing is output.
- `--chirp chirpSeconds` - PositiveInteger. Optional. Output a message saying we're alive every `chirpSeconds` seconds.
- `--action actions` - String. Optional. Onr or more actions permitted `start`, `stop`, `restart`, use comma to separate. Default is `restart`.
- `service0` - Directory. Required. Service to control (e.g. `/etc/service/application/`)
- `file1` - File. Required. Absolute path to a file. Presence of  `file` triggers `action`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:DAEMONTOOLS_HOME.sh} - The default home directory for `daemontools`

